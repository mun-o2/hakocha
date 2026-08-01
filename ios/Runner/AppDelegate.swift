import Flutter
import UIKit
import MultipeerConnectivity

let kMethodChannel = "hakocha/multipeer/methods"
let kEventChannel = "hakocha/multipeer/events"

@main
@objc class AppDelegate: FlutterAppDelegate, FlutterImplicitEngineDelegate {
  private var multipeerManager: MultipeerManager?
  private var eventSink: FlutterEventSink?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    return super.application(
      application,
      didFinishLaunchingWithOptions: launchOptions
    )
  }

  func didInitializeImplicitFlutterEngine(
    _ engineBridge: FlutterImplicitEngineBridge
  ) {
    GeneratedPluginRegistrant.register(
      with: engineBridge.pluginRegistry
    )

    let messenger = engineBridge.applicationRegistrar.messenger()

    let methodChannel = FlutterMethodChannel(
      name: kMethodChannel,
      binaryMessenger: messenger
    )

    let eventChannel = FlutterEventChannel(
      name: kEventChannel,
      binaryMessenger: messenger
    )

    multipeerManager = MultipeerManager()

    multipeerManager?.onEvent = { [weak self] (dict: [String: Any]) in
      DispatchQueue.main.async {
        let action = dict["action"] as? String ?? "unknown"
        print("📤 [EventChannel] Sending event: \(action)")
        self?.eventSink?(dict)
      }
    }

    methodChannel.setMethodCallHandler {
      [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in

      switch call.method {
      case "start":
        if let args = call.arguments as? [String: Any],
           let name = args["displayName"] as? String {
          print("📱 [MethodChannel] start called with displayName: \(name)")
          self?.multipeerManager?.start(withDisplayName: name)
        } else {
          let deviceName = UIDevice.current.name
          print("📱 [MethodChannel] start called (default: \(deviceName))")
          self?.multipeerManager?.start(
            withDisplayName: deviceName
          )
        }

        result(true)

      case "stop":
        print("📱 [MethodChannel] stop called")
        self?.multipeerManager?.stop()
        result(true)

      default:
        result(FlutterMethodNotImplemented)
      }
    }

    eventChannel.setStreamHandler(self)
  }
}

extension AppDelegate: FlutterStreamHandler {
  func onListen(
    withArguments arguments: Any?,
    eventSink events: @escaping FlutterEventSink
  ) -> FlutterError? {
    print("📊 [EventChannel] Listener registered")
    eventSink = events
    return nil
  }

  func onCancel(
    withArguments arguments: Any?
  ) -> FlutterError? {
    print("📊 [EventChannel] Listener cancelled")
    eventSink = nil
    return nil
  }
}