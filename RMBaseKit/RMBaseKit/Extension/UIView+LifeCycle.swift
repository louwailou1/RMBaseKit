
//
//  UIView+LifeCycle.swift
//  eightThousandPoints
//
//  Created by blue on 2017/11/28.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit
// public 只能在自己的模块里面继承和重写，open则是在其他模块也可以
extension UIView {
    @objc open func willAppear() {
        
    }
    @objc open func didAppear() {
        
    }
    @objc open func willDisappear() {
        
    }
    @objc open func didDisappear() {
        
    }
}

extension UIViewController {
    
    public static func perpareSwizzLifeCycle() {
        DispatchQueue.once(token: "RMBaseKit") {
            self.swizzleInstanceSelector(oldSel: #selector(viewWillAppear(_:)), newSel: #selector(newViewWillAppear(_:)))
            self.swizzleInstanceSelector(oldSel: #selector(viewDidAppear(_:)), newSel: #selector(newViewDidAppear(_:)))
            self.swizzleInstanceSelector(oldSel: #selector(viewWillDisappear(_:)), newSel: #selector(newViewWillDisappear(_:)))
            self.swizzleInstanceSelector(oldSel: #selector(viewDidDisappear(_:)), newSel: #selector(newViewDidDisappear(_:)))
        }
    }
    
    @objc func newViewWillAppear(_ animated: Bool) {
        self.newViewWillAppear(animated)
        for view in self.view.subviews {
            view.willAppear()
        }
    }
    
    @objc func newViewDidAppear(_ animated: Bool) {
        self.newViewDidAppear(animated)
        for view in self.view.subviews {
            view.didAppear()
        }
    }
    
    @objc func newViewWillDisappear(_ animated: Bool) {
        self.newViewWillDisappear(animated)
        for view in self.view.subviews {
            view.willDisappear()
        }
    }
    
    @objc func newViewDidDisappear(_ animated: Bool) {
        self.newViewDidDisappear(animated)
        for view in self.view.subviews {
            view.didDisappear()
        }
    }
}

