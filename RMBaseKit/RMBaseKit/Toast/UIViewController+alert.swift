//
//  UIViewController+alert.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/1/4.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    /// alert弹窗，只有确定按钮，纯提示作用
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 内容
    public func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    public func alert(title: String, message: String, sureHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "确定", style: .destructive, handler: { (action) in
            if let sureHandler = sureHandler {
                sureHandler()
            }
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: { (action) in
            if let cancelHandler = cancelHandler {
                cancelHandler()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
