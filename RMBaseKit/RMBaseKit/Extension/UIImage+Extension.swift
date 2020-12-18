//
//  UIImage+Extension.swift
//  BKMainStructureModule
//
//  Created by RMBaseKit on 2018/1/3.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public extension UIImage {
    
    public class func originImage(named: String) -> UIImage? {
        return UIImage(named: named)?.withRenderingMode(.alwaysOriginal)
    }
    
    /// 生成纯色图片
    ///
    /// - Parameters:
    ///   - color: 图片颜色
    ///   - size: 图片尺寸
    public convenience init(color: UIColor, size: CGSize) {
        UIGraphicsBeginImageContextWithOptions(size, false, 1)
        color.setFill()
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            self.init()
            return
        }
        UIGraphicsEndImageContext()
        guard let aCgImage = image.cgImage else {
            self.init()
            return
        }
        self.init(cgImage: aCgImage)
    }
    
    public enum GradientType {
        case TopToBottom        // 从上到下
        case LeftToRight        // 从左到右
        case UpleftToLowright   // 左上到右下
        case UprightToLowleft   // 右上到左下
    }
    
    
    public convenience init?(gradientColors:[UIColor], size:CGSize = CGSize(width: 10, height: 10), gradientType: GradientType, locations: [Float] = [] )
    {
        UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = UIGraphicsGetCurrentContext()
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colors = gradientColors.map {(color: UIColor) -> AnyObject! in return color.cgColor as AnyObject! } as NSArray
        let gradient: CGGradient
        if locations.count > 0 {
            let cgLocations = locations.map { CGFloat($0) }
            gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: cgLocations)!
        } else {
            gradient = CGGradient(colorsSpace: colorSpace, colors: colors, locations: nil)!
        }
        
        var start = CGPoint(x: 0, y: 0), end = CGPoint(x: size.width, y: 0)
        switch gradientType {
        case .TopToBottom:
            start = CGPoint(x: 0, y: 0) ; end = CGPoint(x: 0, y: size.height); break
        case .LeftToRight:
            start = CGPoint(x: 0, y: 0) ; end = CGPoint(x: size.width, y: 0); break
        case .UpleftToLowright:
            start = CGPoint(x: 0, y: 0) ; end = CGPoint(x: size.width, y: size.height); break
        case .UprightToLowleft:
            start = CGPoint(x: size.width, y: 0) ; end = CGPoint(x: 0, y: size.height); break
        }
        
        context!.drawLinearGradient(gradient, start: start, end: end, options: [.drawsAfterEndLocation, .drawsBeforeStartLocation])
        self.init(cgImage:(UIGraphicsGetImageFromCurrentImageContext()?.cgImage!)!)
        UIGraphicsEndImageContext()
    }
}
