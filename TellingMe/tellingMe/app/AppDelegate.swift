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
import RxSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    private(set) var deviceHeight: CGFloat = 0.0
    private(set) var deviceWidth: CGFloat = 0.0
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        KakaoSDK.initSDK(appKey: Bundle.main.kakaoNativeAppKey)
        FirebaseApp.configure()

        Messaging.messaging().delegate = self

        UNUserNotificationCenter.current().delegate = self
        application.registerForRemoteNotifications()
        
        SubscriptionManager.shared.addPaymentQueue()
                
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
    
    func applicationWillTerminate(_ application: UIApplication) {
        SubscriptionManager.shared.removePaymentQueue()
    }

    func setDeviceDimensions(height: CGFloat, width: CGFloat) {
        self.deviceHeight = height
        self.deviceWidth = width
    }
}

extension AppDelegate: MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
        
        // 키체인에 저장되어있는데, 이 값이 fcmToken하고 다르면 token값 변경으로 서버에 전송
        if let token = KeychainManager.shared.load(key: Keys.firebaseToken.rawValue) {
            if token != fcmToken {
                sendFirebaseToken(token)
            }
        } else {
            
        }
    }
    
    
    func sendFirebaseToken(_ token: String) {
        let request = FirebaseTokenRequest(pushToken: token)
        UserAPI.postFirebaseToken(request: request)
            .subscribe(onNext: { _ in
            }, onError: { [weak self] error in
                if case APIError.tokenNotFound = error {
                    print("should move to login")
                } else {
                    print(error)
                }
            }).disposed(by: DisposeBag())
       }
}
