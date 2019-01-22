import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private var originalDimLevel: CGFloat = 1
  private var currentDimLevel: CGFloat?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: "flutter.luckypines.com/screen_dimmer",
                                              binaryMessenger: controller)
    methodChannel.setMethodCallHandler({ [unowned self]
      (call: FlutterMethodCall, result: FlutterResult) -> Void in
      guard call.method == "setDimLevel" else {
        result(FlutterMethodNotImplemented)
        return
      }
      guard let l = call.arguments as? Float else {
        result(FlutterMethodNotImplemented)
        return
      }
      result(self.setDimLevel(l))
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func applicationWillResignActive(_ application: UIApplication) {
    super.applicationWillResignActive(application)
    UIScreen.main.brightness = originalDimLevel
  }
  
  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    if let l = currentDimLevel {
      UIScreen.main.brightness = l
    } else {
        originalDimLevel = UIScreen.main.brightness
        currentDimLevel = originalDimLevel
    }
  }

  private func setDimLevel(_ dimLevel: Float) -> Float {
    currentDimLevel = CGFloat(dimLevel)
    UIScreen.main.brightness = currentDimLevel!
    return dimLevel
  }
}
