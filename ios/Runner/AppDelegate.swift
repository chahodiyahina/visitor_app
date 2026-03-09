/*
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
 */


 import Flutter
 import UIKit
 import Firebase
 import UserNotifications

 @main
 @objc class AppDelegate: FlutterAppDelegate, UNUserNotificationCenterDelegate {

   override func application(
     _ application: UIApplication,
     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
   ) -> Bool {

     // Initialize Firebase
     FirebaseApp.configure()

     // Register Flutter plugins
     GeneratedPluginRegistrant.register(with: self)

     // Set notification delegate
     UNUserNotificationCenter.current().delegate = self

     // Request notification permission
     UNUserNotificationCenter.current().requestAuthorization(
       options: [.alert, .badge, .sound]
     ) { granted, error in
       if granted {
         DispatchQueue.main.async {
           application.registerForRemoteNotifications()
         }
       }
     }

     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
   }
 }
