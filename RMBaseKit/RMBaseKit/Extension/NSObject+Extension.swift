
//
//  NSObject+Extension.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/1/14.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public extension NSObject {
    
    /// 获取指定模块的Bundle
    ///
    /// - Parameter moudleName: 指定模块的名称
    /// - Returns: 返回Bundle,获取不到就直接返回mainBundle
    public func getBundle(withCurrentModule moudleName: String) -> Bundle {
        guard let url = Bundle(for: self.classForCoder).url(forResource: moudleName, withExtension: "bundle"), let bundle = Bundle(url: url) else {
            return Bundle.main
        }
        return bundle
    }
}
