//
//  UIColor+Extension.swift
//  eightThousandPoints
//
//  Created by blue on 2017/7/25.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit

public extension UIColor {
    //MARK:- 随机色
     public static var random : UIColor  {
        let aRedValue   = (CGFloat)(arc4random() % 255),
        aGreenValue = (CGFloat)(arc4random() % 255),
        aBlueValue  = (CGFloat)(arc4random() % 255)
        return UIColor(red: aRedValue / 255.0, green: aGreenValue / 255.0, blue: aBlueValue / 255.0, alpha: 1.0)
    }
    //MARK:- RGBA
    public static func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a / 255.0)
    }
    
    //MARK:- 16进制
    public convenience init(hex string: String, _ alpha: CGFloat = 1.0) {
        var hex = string.hasPrefix("#")
            ? String(string.dropFirst())
            : string
        guard hex.count == 3 || hex.count == 6
            else {
                self.init(white: 1.0, alpha: alpha)
                return
        }
        if hex.count == 3 {
            for (index, char) in hex.enumerated() {
                hex.insert(char, at: hex.index(hex.startIndex, offsetBy: index * 2))
            }
        }
        
        self.init(
            red:   CGFloat((Int(hex, radix: 16)! >> 16) & 0xFF) / 255.0,
            green: CGFloat((Int(hex, radix: 16)! >> 8) & 0xFF) / 255.0,
            blue:  CGFloat((Int(hex, radix: 16)!) & 0xFF) / 255.0, alpha: alpha)
    }
    
    //MARK:- 16进制
    public static func colorWithHexString (hex: String, _ alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
