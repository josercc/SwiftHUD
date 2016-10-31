//
//  SwiftHUD.swift
//  SwiftHUD
//
//  Created by 张行 on 16/8/9.
//  Copyright © 2016年 张行. All rights reserved.
//

import Foundation
import SnapKit

private let MaxHUDWidth:CGFloat = UIScreen.main.bounds.size.width - 40

public typealias SwiftHUDComplete = (_ hud:SwiftHUD) -> Void

public enum SwiftHUDStyle {
    case none
    case info
    case success
    case error
    case loading
}

private var hud:SwiftHUD?

open class SwiftHUD {

    open var hudBackgroundView:UIView{ get{return self._hudBackgroundView} }

    fileprivate(set) var _hudBackgroundView:UIView

    open var loadingView:UIActivityIndicatorView?{ get{return self._loadingView!} }

    fileprivate(set) var _loadingView:UIActivityIndicatorView?

    open var iconImageView:UIImageView?{ get{return self._iconImageView!} }

    fileprivate(set) var _iconImageView:UIImageView?

    open var titleLabel:UILabel{ get{return _titleLabel} }

    fileprivate(set) var _titleLabel:UILabel

    fileprivate var style:SwiftHUDStyle = SwiftHUDStyle.none

    open class func show() -> SwiftHUD {
        return self.show("Loading...")
    }

    open class func show(_ text:String) -> SwiftHUD {
        let view:UIView? = UIApplication.shared.keyWindow?.rootViewController?.view
        assert(view != nil, "must init window rootViewController")
        return self.show(text, view: view!)
    }

    open class func show(_ text:String, view:UIView) ->SwiftHUD {
        return self.show(text, view: view, style: SwiftHUDStyle.none)
    }

    open class func show(_ text:String, view:UIView, style:SwiftHUDStyle) -> SwiftHUD {
        return self.show(text, view: view, style: style, after: 0)
    }

    open class func show(_ text:String, view:UIView, style:SwiftHUDStyle, after:TimeInterval) -> SwiftHUD {
        return self.show(text, view: view, style: style, after: after, complete: nil)
    }

    open class func show(_ text:String, view:UIView, style:SwiftHUDStyle, after:TimeInterval, complete:SwiftHUDComplete?) -> SwiftHUD {
        let hud:SwiftHUD = SwiftHUD(text: text, view: view, style: style, after: after, complete: complete)
        return hud
    }

    open func hide() {
        self.hide("")
    }

    open func hide(_ text:String) {
        self.hide(text, after: 1.5)
    }

    open func hide(_ text:String , after:TimeInterval) {
        self.hide(text, after: after, complete: nil)
    }

    open func hide(_ text:String , after:TimeInterval, complete:SwiftHUDComplete?) {
        if text == "" {
            self.hudBackgroundView.removeFromSuperview()
            return
        }
        self.titleLabel.text = text
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.hudBackgroundView.removeFromSuperview()
            if complete != nil {
                complete!(self)
            }
        })

    }

    required public init(text:String, view:UIView, style:SwiftHUDStyle, after:TimeInterval, complete:SwiftHUDComplete?) {

        if hud != nil && hud!.hudBackgroundView.superview != nil {
            hud!.hudBackgroundView.removeFromSuperview()
        }

        self._hudBackgroundView = UIView()
        self._titleLabel = UILabel()
        self.initHudBackgroundView()
        self.initTitleLabel()
        self._titleLabel.text = text

        switch style {
            case .none:
                self.settingNoneStyle()
            case .info,.error,.success:
                self._iconImageView = UIImageView()
                self.style = style
                self.initIconImageView()
                self.settingInfoStyle(self.iconImageView!)
            case .loading:
                self._loadingView = UIActivityIndicatorView(activityIndicatorStyle: .white)
                self.initLoadingView()
                self.loadingView!.startAnimating()
                self.settingInfoStyle(self.loadingView!)
        }
        view.addSubview(self.hudBackgroundView)
        self.hudBackgroundView.snp_makeConstraints { (make) in
            make.center.equalTo(view)
        }
        if after > 0 {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(after * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                self.hide()
                if complete != nil {
                    complete!(self)
                }
            })
        }

        hud = self
    }

    fileprivate func settingNoneStyle() {

        self.hudBackgroundView.addSubview(self.titleLabel)

        self.titleLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(EdgeInsets(top: 10, left: 10, bottom: -10, right: -10))
            make.width.lessThanOrEqualTo(MaxHUDWidth - 20)
        }
    }

    fileprivate func settingInfoStyle(_ view:UIView) {
        self.hudBackgroundView.addSubview(view)
        self.hudBackgroundView.addSubview(self.titleLabel)

        view.snp_makeConstraints { (make) in
            make.top.equalTo(self.hudBackgroundView).offset(10)
            make.size.equalTo(CGSize(width: 30, height: 30))
            make.centerX.equalTo(self.hudBackgroundView)
        }

        self.titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(view.snp_bottom).offset(10)
            make.left.equalTo(self.hudBackgroundView).offset(10)
            make.right.equalTo(self.hudBackgroundView).offset(-10)
            make.bottom.equalTo(self.hudBackgroundView).offset(-10)
            make.width.lessThanOrEqualTo(MaxHUDWidth - 20)
        }
    }


    fileprivate func imageWithStyle(_ style:SwiftHUDStyle) -> UIImage? {
        switch style {
        case .error:
            return SwiftImageWithName("swift_alert_hud_error")
        case .info:
            return SwiftImageWithName("swift_alert_hud_info")
        case .success:
            return SwiftImageWithName("swift_alert_hud_success")
        case .none,.loading:
            return nil
        }

    }
    fileprivate func initHudBackgroundView() {
        self._hudBackgroundView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        self._hudBackgroundView.layer.masksToBounds = true
        self._hudBackgroundView.layer.cornerRadius = 5
    }

    fileprivate func initLoadingView() {
        self._loadingView!.hidesWhenStopped = true
    }

    fileprivate func initIconImageView() {
        self._iconImageView!.image = self.imageWithStyle(self.style)
    }

    fileprivate func initTitleLabel() {
        self._titleLabel.numberOfLines = 0
        self._titleLabel.font = UIFont.systemFont(ofSize: 13)
        self._titleLabel.lineBreakMode = .byTruncatingTail
        self._titleLabel.textColor = UIColor.white
        self._titleLabel.textAlignment = .center
    }
}

func SwiftImageWithName(_ imageName:String?) -> UIImage? {
    guard let imageName:String = imageName else {
        return nil
    }
    let name = "\(imageName)@\(Int(UIScreen.main.scale))x"

    guard let swiftBundle:Bundle = Bundle(path:Bundle(for: SwiftHUD.self).path(forResource: "SwiftHUD", ofType: "bundle")! ) else {
        return nil
    }
    guard let imagePath:String = swiftBundle.path(forResource: name, ofType: "png") else {
        return nil
    }
    return UIImage(contentsOfFile: imagePath)
}
