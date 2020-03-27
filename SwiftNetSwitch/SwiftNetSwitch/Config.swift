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
        SwitchManager.shared.configHostDebug = ["aaaDebug":"111Debug","bbbDebug":"222Debug"]
        SwitchManager.shared.configHostRelease = ["aaaRelease":"111Release","bbbRelease":"222Release"]
        SwitchManager.shared.configHostDev = ["aaaDev":"111Dev","bbbDev":"222Dev"]
        SwitchManager.shared.configHostOther = ["aaaOther":"111Other","bbbOther":"222Other","cccOther":"333Other","dddOther":"444Other"]
        SwitchManager.shared.setDefaultNetworkConfig()
    }
}
