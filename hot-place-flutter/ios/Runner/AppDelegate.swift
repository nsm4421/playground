import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSService.provideAPIKEY("AIzaSyAIf7UVjg9JqcUBjL4GVpdtWHWWGKGmTG8")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
