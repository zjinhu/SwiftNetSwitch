//
//  ViewController.swift
//  test
//
//  Created by iOS on 2020/3/27.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit
import SwiftNetSwitch
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        SwitchManager.shared.configWithNavBar(self) {
            print("完成")
        }
    }


}

