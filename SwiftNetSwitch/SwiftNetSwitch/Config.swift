//
//  Config.swift
//  SwiftNetSwitch
//
//  Created by iOS on 2020/3/27.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
class Config {
    static func setConfig(){
        SwitchManager.shared.defaultSign = .debug
        
        SwitchManager.shared.configHostDebug = ["DebugSever":"https://Debug.qq.com",
                                                "AppDebugSever":"https://Debug.baidu.com"]
        
        SwitchManager.shared.configHostRelease = ["ReleaseSever":"https://www.qq.com",
                                                  "AppReleaseSever":"https://www.baidu.com"]
        
        SwitchManager.shared.configHostDev = ["DevSever":"https://Dev.qq.com",
                                              "AppDevSever":"https://Dev.baidu.com"]
        
        SwitchManager.shared.configHostOther = ["OtherSever":"https://Other.qq.com",
                                                "AppOtherSever":"https://Other.baidu.com",
                                                "WebOtherSever":"https://Other.sina.com",
                                                "ShopOtherSever":"https://Other.taobao.com"]
        
        SwitchManager.shared.setDefaultNetworkConfig()
    }
}
