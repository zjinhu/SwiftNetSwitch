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
        // Do any additional setup after loading the view.
       let sign = SwitchManager.shared.getSelectNetworkSign()
       let config = SwitchManager.shared.getSelectNetworkConfig()
        print("sin--\(String(describing: sign))--config:\(String(describing: config))")

        #if DEBUG
//        SwitchManager.shared.configWithView(self, self.view) {
//            print("完成")
//        }
//        
//        SwitchManager.shared.configWithFrame(self, CGRect.init(x: 100, y: 100, width: 100, height: 50)) {
//            print("完成")
//        }
        
        SwitchManager.shared.configWithNavBar(self) {
            print("完成")
        }
        #endif

    }


}

