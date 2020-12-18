//
//  UIViewController+HUD.swift
//  GankGoods
//
//  Created by RMBaseKit on 2017/4/25.
//  Copyright © 2017年 RMBaseKit. All rights reserved.
//

import UIKit
import MBProgressHUD

private var HUDKey = "HUDKey"

public extension UIViewController {
    
    var hud : MBProgressHUD?
    {
        get{
            return objc_getAssociatedObject(self, &HUDKey) as? MBProgressHUD
        }
        set{
            objc_setAssociatedObject(self, &HUDKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /**
     显示提示信息(有菊花, 一直显示, 不消失)，默认文字“加载中”，默认偏移量0
     
     - parameter view:    显示在哪个View上
     - parameter hint:    提示信息
     - parameter yOffset: y上的偏移量
     - parameter black:   默认黑色，为true则变成白色
     */
    public func showHud(in view: UIView, hint: String = "加载中...", yOffset:CGFloat? = -64, _ black: Bool = true){
        self.hideHud()
        let HUD = MBProgressHUD(view: view)
        HUD.frame = CGRect(x: 0, y: 64, width: kScreenW, height: kScreenH)
        HUD.label.text = hint
        HUD.label.font = UIFont.systemFont(ofSize: 15)
        //设为false后点击屏幕其他地方有反应
        HUD.isUserInteractionEnabled = true
        if black {
            //HUD内的内容的颜色
            HUD.contentColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.00)
            //View的颜色
            HUD.bezelView.color = UIColor.colorWithHexString(hex: "#000000", 0.7)
        }
        //style -blur 不透明 －solidColor 透明
        HUD.bezelView.style = .solidColor
        HUD.margin = 12
        //偏移量，以center为起点
        HUD.offset.y = yOffset ?? 0
        view.addSubview(HUD)
        HUD.show(animated: true)
        hud = HUD
    }
    
    /**
     显示纯文字提示信息(显示在keywindow上)，默认时间2s，默认偏移量0
     
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
     */
    public func showHintInKeywindow(hint: String, duration: Double = 2.0, yOffset:CGFloat? = 0, _ black: Bool = true) {
        self.hideHud()
        let view = keyWindow
        let HUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.animationType = .zoomOut
        HUD.isUserInteractionEnabled = true
        if black {
            //HUD内的内容的颜色
            HUD.contentColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.00)
            //View的颜色
            HUD.bezelView.color = UIColor.colorWithHexString(hex: "#000000", 0.7)
        }
        HUD.bezelView.style = .solidColor
        HUD.mode = .text
        HUD.label.text = hint
        HUD.show(animated: true)
        HUD.removeFromSuperViewOnHide = false
        HUD.offset.y = yOffset ?? 0
        HUD.margin = 12
        HUD.hide(animated: true, afterDelay: duration)
        HUD.removeFromSuperViewOnHide = true
        hud = HUD
    }
    
    
    
    /**
     显示纯文字提示信息，默认时间1.5s，默认偏移量0
     
     - parameter view: 显示在哪个View上
     - parameter hint: 提示信息
     - parameter duration: 持续时间(不填的话, 默认两秒)
     - parameter yOffset: y上的偏移量
     */
    public func showHint(in view: UIView, hint: String, duration: Double = 1.5, yOffset:CGFloat? = 0, _ black: Bool = true) {
        self.hideHud()
        let HUD = MBProgressHUD(view: view)
        view.addSubview(HUD)
        HUD.animationType = .zoomOut
        if black {
            //HUD内的内容的颜色
            HUD.contentColor = UIColor(red:0.82, green:0.82, blue:0.82, alpha:1.00)
            //View的颜色
            HUD.bezelView.color = UIColor.colorWithHexString(hex: "#000000", 0.7)
        }
        HUD.bezelView.style = .solidColor
        HUD.mode = .text
        HUD.label.text = hint
        HUD.label.numberOfLines = 0
        HUD.isUserInteractionEnabled = false
        HUD.removeFromSuperViewOnHide = false
        HUD.show(animated: true)
        HUD.offset.y = yOffset ?? 0
        HUD.margin = 12
        HUD.hide(animated: true, afterDelay: duration)
        hud = HUD
    }
    
    /// 移除提示
    public func hideHud() {
        //如果解包成功则移除，否则不做任何事
        if let hud = hud {
            hud.hide(animated: false)
            hud.removeFromSuperview()
        }
    }
}


