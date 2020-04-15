//
//  SwitchController.swift
//  SwiftNetSwitch
//
//  Created by iOS on 2020/3/26.
//  Copyright © 2020 iOS. All rights reserved.
//

import UIKit

class SwitchController: UIViewController, UITableViewDelegate, UITableViewDataSource {
 
    typealias CallbackHandler = ((_ name: String) -> Void)
    
    var configURLDic : [String : Any]?{
        didSet{
            guard configURLDic != nil else {
                return
            }
            tableView.reloadData()
        }
    }
    var configName : String?
    var configSelected : CallbackHandler?
     
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none 
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        tableView.estimatedRowHeight = 100;
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 0;
        tableView.estimatedSectionFooterHeight = 0;
        tableView.delaysContentTouches = true
        tableView.contentInsetAdjustmentBehavior = .automatic
        return tableView
    }()
    
    lazy var button : UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 80, height: 44)
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        
        button.setTitle("确认", for: .normal)
        button.addTarget(self, action: #selector(changeNetwork), for: .touchUpInside)
        return button
    }()
    
    lazy var backBtn : UIButton = {
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: 0, width: 80, height: 44)
        button.contentHorizontalAlignment = .left
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.setTitle("取消", for: .normal)
        button.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return button
    }()
    
    var selectedName : String?
    var previousIndex : IndexPath?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "网络环境配置"
        self.view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
        self.view.addSubview(tableView)
        
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return configURLDic?.keys.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellID")
        if  cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "cellID")
        }
        
        cell?.accessoryType = .none
        cell?.detailTextLabel?.font = UIFont.systemFont(ofSize: 12)
        cell?.textLabel?.textColor = .black
        cell?.detailTextLabel?.textColor = .lightGray
        cell?.detailTextLabel?.numberOfLines = 0
        
        let keysArray = [String](configURLDic!.keys)
        let title : String = keysArray[indexPath.row]
        
        switch title{
        case NetworkConfigSign.debug.rawValue:
            cell?.textLabel?.text = kNameDebug
        case NetworkConfigSign.release.rawValue:
            cell?.textLabel?.text =  kNameRelease
        case NetworkConfigSign.dev.rawValue:
            cell?.textLabel?.text =  kNameDev
        case NetworkConfigSign.other.rawValue:
            cell?.textLabel?.text =  kNameOther
        default:
            cell?.textLabel?.text =  "未知"
        }
 
        let dic = configURLDic![title] as! [String : String]
        var detial = ""
        for (key , value) in dic {
            detial.append("\(key)  :  \(value) \n")
        }
        cell?.detailTextLabel?.text = detial
        
        if configName == title{
            cell?.accessoryType = .checkmark
            cell?.textLabel?.textColor = .red
            cell?.detailTextLabel?.textColor = .black
            previousIndex = indexPath
        }
//        cell?.layoutSubviews()
//        cell?.setNeedsUpdateConstraints()
//        cell?.updateConstraints()

        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let keysArray = [String](configURLDic!.keys)
        let title : String = keysArray[indexPath.row]
        selectedName = title
        
        if previousIndex != nil {
            let last = tableView.cellForRow(at: previousIndex!)
            last?.accessoryType = .none
            last?.textLabel?.textColor = .black
            last?.detailTextLabel?.textColor = .lightGray
        }
        let now = tableView.cellForRow(at: indexPath)
        now?.accessoryType = .checkmark
        now?.textLabel?.textColor = .red
        now?.detailTextLabel?.textColor = .black
        previousIndex = indexPath
    }

    @objc
    public func changeNetwork() {
        guard let callback = configSelected, let name = selectedName else {
            return
        }
        callback(name)
        self.dismiss(animated: true) {
            
        }
    }
    
    @objc
    public func goBack() {
        self.dismiss(animated: true) {
            
        }
    }
}
