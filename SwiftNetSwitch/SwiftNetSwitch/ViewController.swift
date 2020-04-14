//
//  ViewController.swift
//  SwiftNetSwitch
//
//  Created by iOS on 2020/3/26.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vi = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 50))
        vi.backgroundColor = .yellow
        self.view.addSubview(vi)
        
        // Do any additional setup after loading the view.
       let sign = SwitchManager.shared.getSelectNetworkSign()
       let config = SwitchManager.shared.getSelectNetworkConfig()
        print("sin--\(String(describing: sign))--config:\(String(describing: config))")

        #if DEBUG

//        添加到VC上的指定位置
//        SwitchManager.shared.configWithFrame(self, CGRect.init(x: 100, y: 100, width: 100, height: 50)) {
//            print("完成")
//        }
        
        //添加到导航栏上并且切换完成后杀死APP
//        SwitchManager.shared.configWithNavBar(self, true) {
//            print("完成")
//        }
        
        //添加到导航栏
//        SwitchManager.shared.configWithNavBar(self) { type in
//            print("完成设置，当前环境：\(type)")
//        }
        
        //添加到指定容器view里
//        SwitchManager.shared.configWithView(self, vi) { type in
//            print("\(type)")
//        }
        
        //添加到指定容器view里，并且切换完成后杀死APP
        SwitchManager.shared.configWithView(self, vi, true) { type in
            print("\(type)")
        }
        #endif

    }


}

