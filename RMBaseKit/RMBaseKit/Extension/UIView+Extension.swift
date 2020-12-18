//
//  UIView+Extension.swift
//  eightThousandPoints
//
//  Created by blue on 2017/9/20.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit

//Swift快速查找Controller 
//https://00red.com/blog/2015/05/23/tips-find-controller/
public extension UIView {
    
    public func findViewController() -> UIViewController? {
        return self.findControllerWith(UIViewController.self)
    }
    
    public func findNavController() -> UINavigationController? {
        return self.findControllerWith(UINavigationController.self)
    }
    
    //根据事件响应链向上查找
    private func findControllerWith<T>(_ clzz: AnyClass) -> T? {
        
        var responder = self.next
        while responder != nil {
            
            if responder!.isKind(of: clzz) {
                return responder as? T
            }
            
            responder = responder?.next
        }
        
        return nil
    }
}
