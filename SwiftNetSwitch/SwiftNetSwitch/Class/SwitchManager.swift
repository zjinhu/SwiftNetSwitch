//
//  SwitchManager.swift
//  SwiftNetSwitch
//
//  Created by iOS on 2020/3/26.
//  Copyright © 2020 iOS. All rights reserved.
//

import Foundation
import UIKit
/// 当前设置的环境名称
public let selectNetworkName = "NetworkSettingHost"

/// 当前设置的环境配置
public let selectNetworkConfig = "NetworkSettingHostDic"

public enum NetworkConfigSign : String{
    case debug = "keyNetworkConfigDebug"
    case release = "keyNetworkConfigRelease"
    case dev = "keyNetworkConfigDev"
    case other = "keyNetworkConfigOther"
}

public let kNameDebug = "Debug环境"
public let kNameRelease = "Release环境"
public let kNameDev = "Dev环境"
public let kNameOther = "其他环境"

class SwitchManager {

    
    /// 单例使用
    public static let shared = SwitchManager()
    
    public let userDefaults = UserDefaults.init(suiteName: "SwiftNetSwitch")
    
    
    /// 网络环境
    public var defaultSign : NetworkConfigSign = .debug
    /// 开发测试环境地址
    public var configHostDebug : [String : Any]?{
        didSet{
            guard let dic = configHostDebug else {
                return
            }
            configDict[NetworkConfigSign.debug.rawValue] = dic
        }
    }
    /// 线上环境地址
    public var configHostRelease : [String : Any]?{
        didSet{
            guard let dic = configHostRelease else {
                return
            }
            configDict[NetworkConfigSign.release.rawValue] = dic
        }
    }
    /// 开发环境地址
    public var configHostDev : [String : Any]?{
        didSet{
            guard let dic = configHostDev else {
                return
            }
            configDict[NetworkConfigSign.dev.rawValue] = dic
        }
    }
    /// 其他环境地址
    public var configHostOther : [String : Any]?{
        didSet{
            guard let dic = configHostOther else {
                return
            }
            configDict[NetworkConfigSign.other.rawValue] = dic
        }
    }
    
    
    private let keyDefaultConfigSign = "keyDefaultConfigSign"
    
    typealias CallbackHandler = (() -> Void)
    
    private var configDict = [String : Any]()
    
    private var isExitApp : Bool? = false
    
    private var callBack : CallbackHandler?
    
    private var controller : UIViewController?
    
    lazy var button : UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 80, height: 44)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        
        button.setTitle(getSelectNetworkName(), for: .normal)
        button.addTarget(self, action: #selector(changeNetwork), for: .touchUpInside)
        return button
    }()
    
    private init() {
        
    }
    
    public func getSelectNetworkSign() -> String? {
        return userDefaults?.object(forKey: selectNetworkName) as? String
    }
    
    public func getSelectNetworkConfig() -> [String : Any]? {
        return userDefaults?.object(forKey: selectNetworkConfig) as? [String : Any]
    }
    
    public func getSelectNetworkName() -> String? {
        switch getSelectNetworkSign() {
        case NetworkConfigSign.debug.rawValue:
            return kNameDebug
        case NetworkConfigSign.release.rawValue:
            return kNameRelease
        case NetworkConfigSign.dev.rawValue:
            return kNameDev
        case NetworkConfigSign.other.rawValue:
            return kNameOther
        case .none,.some(_):
            return "未知"
        }
    }
    
    /// 设置默认环境
    public func setDefaultNetworkConfig() {
        guard let name = getSelectNetworkSign() , let config = getSelectNetworkConfig() else {
            let networkName = defaultSign.rawValue
            let keysArray = [String](configDict.keys)
            
            if keysArray.contains(networkName){
                saveSelectNetworkName(networkName)
                saveSelectNetworkConfig(networkName)
            }
            return
        }
        print("保存的：\(String(describing: name))--\(String(describing: config))")
    }
    
    /// 存储选中的环境key
    /// - Parameter name: key
    private func saveSelectNetworkName(_ name : String) {
        userDefaults?.set(name, forKey: selectNetworkName)
    }
    
    /// 存储选中的环境配置
    /// - Parameter name: key
    private func saveSelectNetworkConfig(_ name : String){
        let dic = configDict[name]
        userDefaults?.set(dic, forKey: selectNetworkConfig)
    }
}
extension SwitchManager {
    
    public func configWithNavBar(_ vc : UIViewController,
                          _ complete : @escaping CallbackHandler,
                          _ exitApp : Bool? = false){
        isExitApp = exitApp
        callBack = complete
        controller = vc
         
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
         
    }
    
    public func configWithFrame(_ vc : UIViewController,
                         _ frame : CGRect ,
                         _ complete : @escaping CallbackHandler,
                         _ exitApp : Bool? = false){
        isExitApp = exitApp
        callBack = complete
        controller = vc
        
        button.frame = frame
        vc.view.addSubview(button)
    }
    
     @objc
     func changeNetwork() {
 
        print("设置前：\(String(describing: getSelectNetworkName()))--\(String(describing: getSelectNetworkConfig()))")
        let vc = SwitchController()
        vc.configURLDic = configDict
        vc.configName = getSelectNetworkSign()
        
        vc.configSelected = { [weak self] name in
            guard let `self` = self else { return }
            self.saveSelectNetworkName(name)
            self.saveSelectNetworkConfig(name)
            
            print("设置后：\(String(describing: self.getSelectNetworkName()))--\(String(describing: self.getSelectNetworkConfig()))")
            
            self.button.setTitle(self.getSelectNetworkName(), for: .normal)
            self.changeNetworkSucc()
        }
        
        let nav = UINavigationController.init(rootViewController: vc)
        controller?.present(nav, animated: true, completion: {
            
        })
        
    }
    
    func changeNetworkSucc(){
        callBack?()
        guard let ex = isExitApp else {
            return
        }
        if ex {
            exit(0)
        }
    }
}
