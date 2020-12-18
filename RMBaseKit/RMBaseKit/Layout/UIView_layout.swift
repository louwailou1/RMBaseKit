//
//  UIView_layout.swift
//  popupView_custom
//
//  Created by blue on 2017/7/26.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit

public extension UIView {
    public var x : CGFloat {
        get{ return self.frame.origin.x }
        set(x) {
            self.frame.origin = CGPoint(x: x, y: self.frame.origin.y)
        }
    }
    public var y : CGFloat {
        get{ return self.frame.origin.y }
        set(y) {
            self.frame.origin = CGPoint(x: self.x, y: y)
        }
    }
    public var width : CGFloat {
        get{ return self.frame.size.width }
        set(width) {
            self.frame.size = CGSize(width: width, height: self.frame.height)
        }
    }
    public var height : CGFloat {
        get{ return self.frame.size.height }
        set(height) {
            self.frame.size = CGSize(width: self.width, height: height)
        }
    }
    public var right : CGFloat {
        get{ return self.frame.origin.x + self.frame.size.width }
        set(right) {
            var frame = self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
    }
    public var bottom: CGFloat {
        get { return self.frame.origin.y + self.frame.size.height }
        set(bottom) {
            var frame = self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
    }
    public var centerX: CGFloat {
        get { return self.center.x }
        set(centerX) {
            self.center = CGPoint(x: centerX, y: self.center.y)
        }
    }
    public var centerY: CGFloat {
        get { return self.center.y }
        set(centerY) {
            self.center = CGPoint(x: self.centerX, y: centerY)
        }
    }
    public var origin: CGPoint {
        get { return self.frame.origin }
        set(origin) {
            var frame = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    public var size: CGSize {
        get { return self.frame.size }
        set(size) {
            var frame = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}
