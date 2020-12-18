//
//  UIViewController+CustomPop.swift
//  RMBaseKit
//
//  Created by RMBaseKit on 2018/1/24.
//  Copyright © 2018年 RMBaseKit. All rights reserved.
//

import UIKit

private var warnViewKey = "RMBaseKitWarnViewKey"

public struct WarnViewConfig {
    
    public init() {}
    
    public var cancelBtnBgColor = UIColor.clear
    public var cancelBtnTitleColor = UIColor(hex: "3b3b3b")
    public var sureBtnBgColor = UIColor.clear
    public var sureBtnTitleColor = UIColor(hex: "EC4216")
    
    public var sureBtnTitle = "确定"
    public var cancelBtnTitle = "取消"
    
    public var titleLabelColor = UIColor(hex: "3b3b3b")
    public var contentLabelColor = UIColor(hex: "3b3b3b")
    
    public var cancelBtnFont: UIFont? = UIFont(name: "PingFangSC-Regular", size: bk_font(16))
    public var sureBtnFont: UIFont? = UIFont(name: "PingFangSC-Regular", size: bk_font(16))
    public var titleLabelFont: UIFont? = UIFont(name: "PingFangSC-Medium", size: bk_font(18))
    public var contentLabelFont = UIFont(name: "PingFangSC-Regular", size: bk_font(16))
}

public extension UIViewController {
    // content  cancelHandler sureHandler
    public func presentWarnView(defaultConfig: WarnViewConfig, title: String?, content: String, cancelHandler:(() -> Void)?, surehandler: @escaping () -> Void ) {
        
        let customWarnView = CustomWarnView(defaultConfig: defaultConfig, frame: CGRect(x: 0, y: 0, width: 285.0/375.0*kScreenW, height: 285.0/375.0*kScreenW*145.0/285.0), title: title, content: content, sureHandler: surehandler, cancelHandler: cancelHandler)
        
        let overlayController = OverlayController(aView: customWarnView, overlayStyle: .BlackTranslucent)
        overlayController.transitionStyle = .Zoom
        overlayController.isAllowOverlayTouch = false
        overlayController.isDismissedOppositeDirection = true
        overlayController.isUsingElastic = false
        overlayController.animateDuration = 0.15
        overlayController.present(animated: true)
        objc_setAssociatedObject(self, &warnViewKey, overlayController, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
    }
    
    public func dismissWarnView(animated: Bool, completions:((OverlayController) -> Void)?) {
        if let overlayController = objc_getAssociatedObject(self, &warnViewKey) as? OverlayController {
            overlayController.dismiss(animated: animated, completions: completions)
        }
    }
    
}


class CustomWarnView: UIView {
    
    var title: String?
    var content: String
    let contentLabel = UILabel()
    var defaultConfig = WarnViewConfig()
    var sureHandler: (() -> Void)?, cancelHandler: (() -> Void)?
    
    init(defaultConfig: WarnViewConfig, frame: CGRect, title: String?, content: String, sureHandler: (() -> Void)?, cancelHandler: (() -> Void)?) {
        self.sureHandler = sureHandler
        self.cancelHandler = cancelHandler
        self.content = content
        self.title = title
        self.defaultConfig = defaultConfig
        super.init(frame: frame)
        
        setup()
    }
    
    private override init(frame: CGRect) {
        self.content = ""
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = .white
        self.layer.cornerRadius = 4
        
        var selfH = self.height
        let selfW = self.width
        let contentW = selfW - 30
        var contentH = CGFloat(MAXFLOAT)
        let buttonH: CGFloat = 44.0/145.0*self.height
        
        // content
        contentLabel.numberOfLines = 0
        contentLabel.text = self.content
        contentLabel.textAlignment = .left
        contentLabel.textColor = defaultConfig.contentLabelColor
        self.addSubview(contentLabel)
        
        contentLabel.font = defaultConfig.contentLabelFont
        contentLabel.center = CGPoint(x: self.width*0.5, y: (selfH - buttonH + 35)*0.5)
        contentLabel.bounds = self.content.sizeWithText(font: defaultConfig.contentLabelFont!, size: CGSize(width: contentW, height: contentH))
        contentH = contentLabel.bounds.height
        
        if let title = self.title {
            let titleLabel = UILabel()
            titleLabel.frame = CGRect(x: 0, y: 15, width: self.width-30, height: 25)
            titleLabel.center = CGPoint(x: self.width*0.5, y: titleLabel.center.y)
            titleLabel.text = title
            titleLabel.textAlignment = .center
            titleLabel.textColor = defaultConfig.titleLabelColor
            titleLabel.font = defaultConfig.titleLabelFont
            self.addSubview(titleLabel)
            
            if 40 + contentH + 1 + buttonH < selfH {
                // selfH 不变
            }else if 40 + contentH + 1 + buttonH > selfH*2  {
                selfH = selfH*2 + 10
                
                contentLabel.removeFromSuperview()
                let scrollview = UIScrollView(frame: CGRect(x: 20, y: 45, width: contentW, height: selfH - buttonH - 1 - 40 - 20))
                scrollview.contentSize = CGSize(width: contentW, height: contentH)
                self.addSubview(scrollview)
                scrollview.addSubview(contentLabel)
                contentLabel.frame = CGRect(x: 0, y: 0, width: contentW, height: contentH)
            }else {
                selfH = 40 + contentH + 1 + buttonH + 10
                contentLabel.center = CGPoint(x: self.width*0.5, y: (selfH - buttonH + 35)*0.5)
            }
            
            
            
        }else {
            
            if contentH + 1 + buttonH < selfH {
                // selfH 不变
                selfH = selfH + 10
                contentLabel.center = CGPoint(x: self.width*0.5, y: (selfH - buttonH)*0.5)
            }else if contentH + 1 + buttonH > selfH*2  {
                selfH = selfH*2 + 10
                
                contentLabel.removeFromSuperview()
                let scrollview = UIScrollView(frame: CGRect(x: 20, y: 10, width: contentW, height: selfH - buttonH - 1 - 20))
                scrollview.contentSize = CGSize(width: contentW, height: contentH)
                self.addSubview(scrollview)
                scrollview.addSubview(contentLabel)
                contentLabel.frame = CGRect(x: 0, y: 0, width: contentW, height: contentH)
            }else {
                selfH = contentH + 1 + buttonH + 30
                contentLabel.center = CGPoint(x: self.width*0.5, y: (selfH - buttonH)*0.5)
            }
            
            
        }
        self.height = selfH
        let buttonY: CGFloat = selfH - buttonH
        
        // 添加两个分割线
        let Hline = UIView()
        Hline.isHidden = true
        Hline.backgroundColor = UIColor(hex: "e3e3e3")
        Hline.frame = CGRect(x: self.width*0.5, y: buttonY, width: 1, height: buttonH)
        
        let Vline = UIView()
        Vline.backgroundColor = UIColor(hex: "e3e3e3")
        Vline.frame = CGRect(x: 0, y: buttonY-1, width: self.width, height: 1)
        
        
        if let _ = sureHandler {
            let sureButton = UIButton(frame: CGRect(x: 0, y: buttonY, width: self.width, height: buttonH))
            sureButton.setTitle(defaultConfig.sureBtnTitle, for: .normal)
            sureButton.titleLabel?.font = defaultConfig.sureBtnFont
            sureButton.setTitleColor(defaultConfig.sureBtnTitleColor, for: .normal)
            sureButton.backgroundColor = defaultConfig.sureBtnBgColor
            sureButton.addTarget(self, action: #selector(sureButtonClick(_:)), for: .touchUpInside)
            self.addSubview(sureButton)
            
            if let _ = cancelHandler {
                sureButton.frame = CGRect(x: self.width*0.5, y: buttonY, width: self.width*0.5, height: buttonH)
                Hline.isHidden = false
            }
        }
        
        if let _ = cancelHandler {
            let cancelButton = UIButton(frame: CGRect(x: 0, y: buttonY, width: self.width, height: buttonH))
            cancelButton.setTitle(defaultConfig.cancelBtnTitle, for: .normal)
            cancelButton.titleLabel?.font = defaultConfig.cancelBtnFont
            cancelButton.setTitleColor(defaultConfig.cancelBtnTitleColor, for: .normal)
            cancelButton.backgroundColor = defaultConfig.sureBtnBgColor
            cancelButton.addTarget(self, action: #selector(cancelClicked(_:)), for: .touchUpInside)
            self.addSubview(cancelButton)
            
            if let _ = sureHandler {
                cancelButton.frame = CGRect(x: 0, y: buttonY, width: self.width*0.5, height: buttonH)
                Hline.isHidden = false
            }
        }
        
        self.addSubview(Hline)
        self.addSubview(Vline)
        
    }
    
    @objc func sureButtonClick(_ okButton: UIButton) {
        sureHandler!()
    }
    
    @objc func cancelClicked(_ cancelBtn: UIButton) {
        cancelHandler!()
    }
}
