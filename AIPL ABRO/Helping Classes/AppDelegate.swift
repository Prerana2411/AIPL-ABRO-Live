//
//  AppDelegate.swift
//  AIPL ABRO
//
//  Created by promatics on 20/01/18.
//  Copyright © 2018 promatics. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MobileRTC

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MobileRTCAuthDelegate{
    
    
    var window: UIWindow?
    
    var nav : UINavigationController!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let kSDKAppKey = "ulE1nuOKybZV4vRfcUtuC0fleFVt1tsBiV5V"
        let kSDKAppSecret = "444TPFTVvTfQgeIw4MT4SQuS0kF1Rt0ohxWb"
        let kSDKDomain = "zoom.us"
        
        // Step 1: Set SDK Domain and Enable log (You may disable the log feature in release version).
        MobileRTC.shared().setMobileRTCDomain(kSDKDomain)
        
        // Step 2: Get Auth Service
        let authService = MobileRTC.shared().getAuthService()
        
        print("MobileRTC Version: \(MobileRTC.shared().mobileRTCVersion())")
        
        print(authService)
        
        if authService != nil {
            // Step 3: Setup Auth Service
            authService?.delegate = self
            
            authService?.clientKey = kSDKAppKey
            authService?.clientSecret = kSDKAppSecret
            // Step 4: Call authentication function to initialize SDK
            authService?.sdkAuth()

        }
       
        // IQKeyboardManager.sharedManager().enable = true
        IQKeyboardManager.shared.enable = true
        
        //UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for:UIBarMetrics.default)
        
        let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
        
        let pushNotificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
        
        application.registerUserNotificationSettings(pushNotificationSettings)
        
        application.applicationIconBadgeNumber = 0
        
        UserDefaults.standard.setValue("53eef4b20251d4edc73734def033784b1fa174f966c8ad8abb6a5279a28031bc", forKey: "token")
        
        application.registerForRemoteNotifications()
        
        return true
    }
    
    func onMobileRTCAuthReturn(_ returnValue: MobileRTCAuthError) {
        print("onMobileRTCAuthReturn \(returnValue)")
        
        if returnValue != MobileRTCAuthError_Success {
            let message = String(format: NSLocalizedString("SDK authentication failed, error code: %zd", comment: ""), returnValue as! CVarArg)
            print("\(message)")
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        
        
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        
        
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        
        
        
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        
        print(token)
        
        UserDefaults.standard.set(token, forKey: "token")
        
        print(UserDefaults.standard.set(token, forKey: "token"))
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print(application.applicationIconBadgeNumber)
        
        application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
        
        
        if application.applicationState == .inactive || application.applicationState == .background {
            
            let rootViewController = self.window!.rootViewController as! UINavigationController
            
            //    self.nav = rootViewController.tabBarController as! UITabBarController
            
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            
            let vc = mainStoryboard.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
            
            rootViewController.pushViewController(vc, animated: true)
            
            //  self.nav!.pushViewController(vc, animated:false)
            
        }
        
        
    }
    
}

