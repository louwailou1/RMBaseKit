//
//  UIApplication+Extension.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/3/28.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public protocol SelfAware: class {
    static func awake()
}

extension UIApplication {
    
    private static let runOnce: Void = {
        NothingToSeeHere.harmlessFunction()
        
//        UINavigationController.sx_initialize
//        if #available(iOS 11.0, *) {
//            UINavigationBar.sx_initialize
//        }
    }()
    
    open override var next: UIResponder? {
        UIApplication.runOnce
        return super.next
    }
}

class NothingToSeeHere {
    
    static func harmlessFunction() {
        
        let typeCount = Int(objc_getClassList(nil, 0))
        let types = UnsafeMutablePointer<AnyClass?>.allocate(capacity: typeCount)
        objc_getClassList(AutoreleasingUnsafeMutablePointer<AnyClass>(types), Int32(typeCount))
        for index in 0 ..< typeCount { (types[index] as? SelfAware.Type)?.awake() }
        types.deallocate(capacity: typeCount)
        
    }
}
