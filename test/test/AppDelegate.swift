//
//  AppDelegate.swift
//  test
//
//  Created by iOS on 2020/3/27.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftNetSwitch
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SwitchManager.shared.defaultSign = .debug
        SwitchManager.shared.configHostDebug = ["aaaDebug":"111Debug","bbbDebug":"222Debug"]
        SwitchManager.shared.configHostRelease = ["aaaRelease":"111Release","bbbRelease":"222Release"]
        SwitchManager.shared.configHostDev = ["aaaDev":"111Dev","bbbDev":"222Dev"]
        SwitchManager.shared.configHostOther = ["aaaOther":"111Other","bbbOther":"222Other","cccOther":"333Other","dddOther":"444Other"]
        SwitchManager.shared.setDefaultNetworkConfig()
        return true
    }

    // MARK: UISceneSession Lifecycle
@available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
@available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

