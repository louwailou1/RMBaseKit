//
//  NSString+Extension.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/4/23.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

public extension NSString {
    
    /// 计算富文本高度
    ///
    /// - Parameters:
    ///   - lineSpeace: 行高
    ///   - font: 字体
    ///   - width: 字体所占宽度
    ///   - firstLineHeadIndent: 首行缩进
    /// - Returns: 返回字体高度
    public func heightParagraphSpeace(lineSpeace: CGFloat, font: UIFont, width: CGFloat, firstLineHeadIndent: CGFloat) -> CGFloat {
        let paraStyle = NSMutableParagraphStyle()
        // 行高
        paraStyle.lineSpacing = lineSpeace
        paraStyle.firstLineHeadIndent = firstLineHeadIndent
        // NSKernAttributeName字体间距
        let dic = [NSAttributedString.Key.font:font, NSAttributedString.Key.paragraphStyle: paraStyle, NSAttributedString.Key.kern: NSNumber(value: 1.5)]
        let size = self.boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin,.usesFontLeading], attributes: dic, context: nil)
        return size.height
    }
    
}

