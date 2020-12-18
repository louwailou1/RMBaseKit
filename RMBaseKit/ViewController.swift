//
//  ViewController.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/1/4.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(BKDeviceID())
        
        print(kNaviBarH)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        var config = WarnViewConfig()
////        config.contentLabelFont = UIFont(name: "PingFangSC-Medium", size: 18)
//
//        self.presentWarnView(defaultConfig: config, title: "leasin", content: "确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上证指数确确认删除上", cancelHandler: {[unowned self] in
//            self.dismissWarnView(animated: true, completions: nil)
//        }) {
//            self.dismissWarnView(animated: true, completions: nil)
//        }
        
        
//        config.sureBtnTitleColor = UIColor(hex: "3b3b3b")
//        self.presentWarnView(defaultConfig: config, title: nil, content: "可用数量不足", cancelHandler: nil) {
//            self.dismissWarnView(animated: true, completions: nil)
//        }
        
        
        self.showHint(in: self.view, hint: "确认删除上证指数确确认删除上")
    }
}

