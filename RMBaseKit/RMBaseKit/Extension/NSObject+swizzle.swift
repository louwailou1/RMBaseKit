//
//  NSObject+swizzle.swift
//  test_swizzle
//
//  Created by RMBaseKit on 2017/11/28.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit

public extension NSObject {
    public static func swizzleInstanceSelector(oldSel: Selector, newSel: Selector) {
        guard let oldMethod = class_getInstanceMethod(self, oldSel), let newMethod = class_getInstanceMethod(self, newSel) else {
            return
        }
        guard let oldImp = class_getMethodImplementation(self, oldSel), let newImp = class_getMethodImplementation(self, newSel) else {
            return
        }
        
        // 验证本类是否有oldSel的实现
        let vertify = class_addMethod(self, oldSel, newImp, method_getTypeEncoding(newMethod))
        if !vertify {
            method_exchangeImplementations(oldMethod, newMethod)
        }else {
            // 将父类的实现替换到我们的新方法
            class_replaceMethod(self, newSel, oldImp, method_getTypeEncoding(oldMethod))
        }
    }
    
}
