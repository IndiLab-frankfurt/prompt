import UIKit
// import FirebaseCore
 import Flutter
// import Firebase

// @UIApplicationMain

//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     FirebaseApp.configure()
//   }
// }
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
//class AppDelegate: UIResponder, UIApplicationDelegate {

//  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    return true
  }
}
