//
//  AppDelegate.swift
//  tellingMe
//
//  Created by 마경미 on 08.03.23.
//

import UIKit
import KakaoSDKCommon
import FirebaseCore
import UserNotifications
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        KakaoSDK.initSDK(appKey: Bundle.main.kakaoNativeAppKey)
//        FirebaseApp.configure()
//
//        // [START set_messaging_delegate]
//        Messaging.messaging().delegate = self
//        // [END set_messaging_delegate]
//
//        // Register for remote notifications. This shows a permission dialog on first run, to
//        // show the dialog at a more appropriate time move this registration accordingly.
//        // [START register_for_notifications]
//
//        UNUserNotificationCenter.current().delegate = self
//
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//          options: authOptions,
//          completionHandler: { _, _ in }
//        )
//
//        application.registerForRemoteNotifications()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.performAutoLogin()
        }
        self.window?.makeKeyAndVisible()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

extension AppDelegate {
    private func removeKeychainAtFirstLaunch() {
        if UserDefaults.isFirstLaunch() {
            KeychainManager.shared.deleteAll()
        } else {
            self.performAutoLogin()
        }
    }

    func performAutoLogin() {
        guard let type = KeychainManager.shared.load(key: Keys.socialLoginType.rawValue) else {
            return
        }
        guard let socialId = KeychainManager.shared.load(key: Keys.socialId.rawValue) else {
            return
        }
        if type == "kakao" {
            let request = OauthRequest(socialId: socialId)
            LoginAPI.postKakaoOauth(type: "kakao", request: request) { result in
                switch result {
                case .success(let response):
                    KeychainManager.shared.save(response!.accessToken, key: "accessToken")
                    KeychainManager.shared.save(response!.refreshToken, key: "refreshToken")
                    self.showHome()
                case .failure(let error):
                    print(error)
                }
            }
        } else if type == "apple" {
            LoginAPI.postAppleOauth(type: "apple", token: socialId, request: OauthRequest(socialId: "")) { result in
                switch result {
                case .success(let response):
                    KeychainManager.shared.save(response!.accessToken, key: "accessToken")
                    KeychainManager.shared.save(response!.refreshToken, key: "refreshToken")
                    self.showHome()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    func showHome() {
        // 로그인 화면의 뷰 컨트롤러를 생성합니다.
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        guard let tabBarController = storyboard.instantiateViewController(withIdentifier: "mainTabBar") as? MainTabBarController else { return }

        // MainTabBar의 두 번째 탭으로 이동합니다.
        tabBarController.selectedIndex = 1

        // 로그인 화면을 윈도우의 rootViewController로 설정합니다.
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
}


//extension AppDelegate: MessagingDelegate {
//  // [START refresh_token]
////  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
////    print("Firebase registration token: \(String(describing: fcmToken))")
////
//////    let dataDict: [String: String] = ["token": fcmToken ?? ""]
//////    NotificationCenter.default.post(
//////      name: Notification.Name("FCMToken"),
//////      object: nil,
//////      userInfo: dataDict
//////    )
//////    // TODO: If necessary send token to application server.
//////    // Note: This callback is fired at each app startup and whenever a new token is generated.
////  }
////
////  // [END refresh_token]
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//  // Receive displayed notifications for iOS 10 devices.
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              willPresent notification: UNNotification) async
//    -> UNNotificationPresentationOptions {
//    let userInfo = notification.request.content.userInfo
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//    // ...
//
//    // Print full message.
//    print(userInfo)
//
//    // Change this to your preferred presentation option
//    return [[.alert, .sound]]
//  }
//
//  func userNotificationCenter(_ center: UNUserNotificationCenter,
//                              didReceive response: UNNotificationResponse) async {
//    let userInfo = response.notification.request.content.userInfo
//
//    // ...
//
//    // With swizzling disabled you must let Messaging know about the message, for Analytics
//    // Messaging.messaging().appDidReceiveMessage(userInfo)
//
//    // Print full message.
//    print(userInfo)
//  }
//}
