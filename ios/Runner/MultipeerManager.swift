import Foundation
import MultipeerConnectivity

class MultipeerManager: NSObject {
    private let serviceType = "hakochaex"

    private var peerID: MCPeerID!
    private var session: MCSession?
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?

    // event callback
    var onEvent: (([String: Any]) -> Void)?

    // 一旦ダミー
    // 実機A/Bでここを変えてテストしてOK
    // A
    
    private var localUserInfo: [String: Any] = [
        "userId": "user_001",
        "name": "みう",
        "exchangeCode": "ABCD1234"
    ]
    

    // B
    /*
    private var localUserInfo: [String: Any] = [
    "userId": "user_002",
    "name": "あかり",
    "exchangeCode": "EFGH5678"
    
]

*/
    func start(withDisplayName name: String) {
        stop()

        peerID = MCPeerID(displayName: name)

        print("🔍 [Multipeer] 探索開始: \(name)")

        session = MCSession(
            peer: peerID,
            securityIdentity: nil,
            encryptionPreference: .required
        )
        session?.delegate = self

        advertiser = MCNearbyServiceAdvertiser(
            peer: peerID,
            discoveryInfo: nil,
            serviceType: serviceType
        )
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()

        browser = MCNearbyServiceBrowser(
            peer: peerID,
            serviceType: serviceType
        )
        browser?.delegate = self
        browser?.startBrowsingForPeers()
    }

    func stop() {
        print("🛑 [Multipeer] 探索停止")

        advertiser?.stopAdvertisingPeer()
        advertiser?.delegate = nil
        advertiser = nil

        browser?.stopBrowsingForPeers()
        browser?.delegate = nil
        browser = nil

        session?.disconnect()
        session?.delegate = nil
        session = nil
    }

    private func sendUserInfo() {
        guard let session = session else {
            print("❌ [Multipeer] session がありません")
            return
        }

        guard !session.connectedPeers.isEmpty else {
            print("❌ [Multipeer] 接続済みPeerがありません")
            return
        }

        let message: [String: Any] = [
            "type": "userInfo",
            "payload": localUserInfo
        ]

        do {
            let data = try JSONSerialization.data(
                withJSONObject: message,
                options: []
            )

            try session.send(
                data,
                toPeers: session.connectedPeers,
                with: .reliable
            )

            print("📤 [Multipeer] userInfo送信")
            print("   userId: \(localUserInfo["userId"] ?? "")")
            print("   name: \(localUserInfo["name"] ?? "")")
        } catch {
            print("❌ [Multipeer] userInfo送信失敗: \(error.localizedDescription)")

            onEvent?([
                "action": "error",
                "message": "send_user_info_failed",
                "detail": error.localizedDescription
            ])
        }
    }
}

// MARK: - Advertiser
extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        print("📩 [Multipeer] Invite受信: \(peerID.displayName)")

        guard let session = session else {
            print("❌ [Multipeer] Invite受信したが session がありません")
            invitationHandler(false, nil)
            return
        }

        invitationHandler(true, session)
    }

    func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didNotStartAdvertisingPeer error: Error
    ) {
        print("❌ [Multipeer] Advertiser Error: \(error.localizedDescription)")

        onEvent?([
            "action": "error",
            "message": "advertiser_failed",
            "detail": error.localizedDescription
        ])
    }
}

// MARK: - Browser
extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(
        _ browser: MCNearbyServiceBrowser,
        foundPeer peerID: MCPeerID,
        withDiscoveryInfo info: [String: String]?
    ) {
        print("✅ [Multipeer] Peer発見！")
        print("   displayName: \(peerID.displayName)")

        onEvent?([
            "action": "found",
            "peerId": peerID.displayName,
            "displayName": peerID.displayName,
            "connectionState": "notConnected"
        ])

        guard let session = session else {
            print("❌ [Multipeer] Peer発見したが session がありません")
            return
        }

        // 同じPeerに何度もinviteしない
        if session.connectedPeers.contains(peerID) {
            print("ℹ️ [Multipeer] すでに接続済み: \(peerID.displayName)")
            return
        }

        print("📨 [Multipeer] Invite送信: \(peerID.displayName)")

        browser.invitePeer(
            peerID,
            to: session,
            withContext: nil,
            timeout: 10
        )
    }

    func browser(
        _ browser: MCNearbyServiceBrowser,
        lostPeer peerID: MCPeerID
    ) {
        print("👋 [Multipeer] Peerを見失いました: \(peerID.displayName)")

        onEvent?([
            "action": "lost",
            "peerId": peerID.displayName,
            "displayName": peerID.displayName
        ])
    }

    func browser(
        _ browser: MCNearbyServiceBrowser,
        didNotStartBrowsingForPeers error: Error
    ) {
        print("❌ [Multipeer] Browser Error: \(error.localizedDescription)")

        onEvent?([
            "action": "error",
            "message": "browser_failed",
            "detail": error.localizedDescription
        ])
    }
}

// MARK: - MCSession
extension MultipeerManager: MCSessionDelegate {
    func session(
        _ session: MCSession,
        peer peerID: MCPeerID,
        didChange state: MCSessionState
    ) {
        switch state {
        case .notConnected:
            print("❌ [Multipeer] Disconnected: \(peerID.displayName)")

            onEvent?([
                "action": "connectionStateChanged",
                "peerId": peerID.displayName,
                "connectionState": "notConnected"
            ])

        case .connecting:
            print("⏳ [Multipeer] Connecting: \(peerID.displayName)")

            onEvent?([
                "action": "connectionStateChanged",
                "peerId": peerID.displayName,
                "connectionState": "connecting"
            ])

        case .connected:
            print("🔗 [Multipeer] Connected: \(peerID.displayName)")

            onEvent?([
                "action": "connectionStateChanged",
                "peerId": peerID.displayName,
                "connectionState": "connected"
            ])

            // 接続できたら自分のユーザー情報を送る
            sendUserInfo()

        @unknown default:
            print("⚠️ [Multipeer] Unknown connection state")
        }
    }

    func session(
        _ session: MCSession,
        didReceive data: Data,
        fromPeer peerID: MCPeerID
    ) {
        do {
            guard
                let json = try JSONSerialization.jsonObject(
                    with: data,
                    options: []
                ) as? [String: Any],
                let type = json["type"] as? String
            else {
                print("❌ [Multipeer] 受信データの形式が不正")
                return
            }

            switch type {
            case "userInfo":
                guard let payload = json["payload"] as? [String: Any] else {
                    print("❌ [Multipeer] userInfo payload がありません")
                    return
                }

                let userId = payload["userId"] as? String ?? ""
                let name = payload["name"] as? String ?? ""
                let exchangeCode = payload["exchangeCode"] as? String ?? ""

                print("📥 [Multipeer] userInfo受信")
                print("   userId: \(userId)")
                print("   name: \(name)")

                onEvent?([
                    "action": "userInfoReceived",
                    "peerId": peerID.displayName,
                    "userId": userId,
                    "name": name,
                    "exchangeCode": exchangeCode
                ])

            default:
                print("ℹ️ [Multipeer] 未対応message type: \(type)")
            }
        } catch {
            print("❌ [Multipeer] 受信データ解析失敗: \(error.localizedDescription)")

            onEvent?([
                "action": "error",
                "message": "decode_failed",
                "detail": error.localizedDescription
            ])
        }
    }

    func session(
        _ session: MCSession,
        didReceive stream: InputStream,
        withName streamName: String,
        fromPeer peerID: MCPeerID
    ) {
        // 今回は未使用
    }

    func session(
        _ session: MCSession,
        didStartReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        with progress: Progress
    ) {
        // 今回は未使用
    }

    func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {
        // 今回は未使用
    }
}