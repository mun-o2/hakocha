import Foundation
import MultipeerConnectivity

class MultipeerManager: NSObject {
    private var serviceType = "hakochaex"
    private var peerID: MCPeerID!
    private var advertiser: MCNearbyServiceAdvertiser?
    private var browser: MCNearbyServiceBrowser?

    // event callback
    var onEvent: (([String: Any]) -> Void)?

    func start(withDisplayName name: String) {
        stop()
        peerID = MCPeerID(displayName: name)
        print("🔍 [Multipeer] 探索開始: \(name)")

        advertiser = MCNearbyServiceAdvertiser(peer: peerID, discoveryInfo: nil, serviceType: serviceType)
        advertiser?.delegate = self
        advertiser?.startAdvertisingPeer()

        browser = MCNearbyServiceBrowser(peer: peerID, serviceType: serviceType)
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
    }
}

extension MultipeerManager: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        // We don't accept invitations here; discovery-only for now
        invitationHandler(false, nil)
    }

    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        print("❌ [Multipeer] Advertiser Error: \(error.localizedDescription)")
        onEvent?( ["action": "error", "message": "advertiser_failed", "detail": error.localizedDescription] )
    }
}

extension MultipeerManager: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("✅ [Multipeer] Peer発見！")
        print("   displayName: \(peerID.displayName)")
        onEvent?( ["action": "found", "peerId": peerID.displayName, "displayName": peerID.displayName, "connectionState": "notConnected"] )
    }

    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("👋 [Multipeer] Peerを見失いました: \(peerID.displayName)")
        onEvent?( ["action": "lost", "peerId": peerID.displayName, "displayName": peerID.displayName] )
    }

    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        print("❌ [Multipeer] Browser Error: \(error.localizedDescription)")
        onEvent?( ["action": "error", "message": "browser_failed", "detail": error.localizedDescription] )
    }
}
