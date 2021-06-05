//
//  UIButton+ZT.swift
//  ZTImageTitleButton
//
//  Created by zhangtian on 2021/6/3.
//

import UIKit

extension UIView {
    var size: CGSize {self.frame.size}
    var origin: CGPoint {self.frame.origin}
    var W: CGFloat {self.size.width}
    var H: CGFloat {self.size.height}
    var X: CGFloat {self.origin.x}
    var Y: CGFloat {self.origin.y}
}

public enum ZTButtonLayoutStyle {
    case imageTop
    case imageBottom
    case imageLeft
    case imageRight
}

public extension UIButton {
    var zt_contentEdgeInsets: UIEdgeInsets {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.zt_contentEdgeInsets) as? UIEdgeInsets {return obj}
            self.zt_contentEdgeInsets = .zero
            return self.zt_contentEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_contentEdgeInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if newValue != .zero {self.addContentEdgeInsets()}
        }
    }
    var zt_imageLayoutStyle: ZTButtonLayoutStyle {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.zt_imageLayoutStyle) as? ZTButtonLayoutStyle {return obj}
            self.zt_imageLayoutStyle = .imageLeft
            return self.zt_imageLayoutStyle
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_imageLayoutStyle, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    var zt_imageTitleSpacing: CGFloat {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.zt_imageTitleSpacing) as? CGFloat {return obj}
            self.zt_imageTitleSpacing = 0
            return self.zt_imageTitleSpacing
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.zt_imageTitleSpacing, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
}

public extension UIButton {
    func zt_layout(style: ZTButtonLayoutStyle, spacing: CGFloat) {
        self.zt_imageLayoutStyle = style
        self.zt_imageTitleSpacing = spacing
        layout(style: style, spacing: spacing)
    }
}

extension UIButton {
    private struct AssociatedKeys {
        static var zt_contentEdgeInsets = "zt_contentEdgeInsets"
        static var zt_imageLayoutStyle = "zt_imageLayoutStyle"
        static var zt_imageTitleSpacing = "zt_imageTitleSpacing"
        static var raw_contentEdgeInsets = "raw_contentEdgeInsets"
        static var zt_disposeBag = "zt_disposeBag"
    }
    private var raw_contentEdgeInsets: UIEdgeInsets {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociatedKeys.raw_contentEdgeInsets) as? UIEdgeInsets {return obj}
            self.raw_contentEdgeInsets = .zero
            return self.raw_contentEdgeInsets
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.raw_contentEdgeInsets, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIButton {
    open override func draw(_ rect: CGRect) {
        self.layout(style: self.zt_imageLayoutStyle, spacing: self.zt_imageTitleSpacing)
    }
}

extension UIButton {
    private func layout(style: ZTButtonLayoutStyle, spacing: CGFloat) {
        self.contentHorizontalAlignment = .center
        self.contentVerticalAlignment = .center
        guard let titleLabel = self.titleLabel, let imageView = self.imageView else { return }
        
        let maxH = max(titleLabel.H, imageView.H)
        let allH = titleLabel.H + imageView.H
        let maxW = max(titleLabel.W, imageView.W)
        let allW = titleLabel.W + imageView.W
        
        
        switch style {
        case .imageTop:
            self.contentEdgeInsets = .init(top: (allH-maxH+spacing)/2, left: -(allW-maxW)/2, bottom: (allH-maxH+spacing)/2, right: -(allW-maxW)/2)
            self.titleEdgeInsets = .init(top: imageView.H+spacing, left: -imageView.W, bottom: 0, right: 0)
            self.imageEdgeInsets = .init(top: -titleLabel.H-spacing, left: 0, bottom: 0, right: -titleLabel.W)
        case .imageBottom:
            self.contentEdgeInsets = .init(top: (allH-maxH+spacing)/2, left: -(allW-maxW)/2, bottom: (allH-maxH+spacing)/2, right: -(allW-maxW)/2)
            self.titleEdgeInsets = .init(top: 0, left: -imageView.W, bottom: imageView.H+spacing, right: 0)
            self.imageEdgeInsets = .init(top: 0, left: 0, bottom: -titleLabel.H-spacing, right: -titleLabel.W)
        case .imageLeft:
            self.contentEdgeInsets = .init(top: 0, left: spacing/2, bottom: 0, right: spacing/2)
            self.titleEdgeInsets = .init(top: 0, left: 0, bottom: 0, right: -spacing)
            self.imageEdgeInsets = .init(top: 0, left: -spacing, bottom: 0, right: 0)
        case .imageRight:
            self.contentEdgeInsets = .init(top: 0, left: spacing/2, bottom: 0, right: spacing/2)
            self.titleEdgeInsets = .init(top: 0, left: -imageView.W-spacing, bottom: 0, right: imageView.W)
            self.imageEdgeInsets = .init(top: 0, left: titleLabel.W, bottom: 0, right: -titleLabel.W-spacing)
        }
        
        self.raw_contentEdgeInsets = self.contentEdgeInsets
        if self.zt_contentEdgeInsets != .zero {self.addContentEdgeInsets()}
    }
    
    private func addContentEdgeInsets() {
        let inset = UIEdgeInsets(top: self.raw_contentEdgeInsets.top + self.zt_contentEdgeInsets.top,
                                 left: self.raw_contentEdgeInsets.left + self.zt_contentEdgeInsets.left,
                                 bottom: self.raw_contentEdgeInsets.bottom + self.zt_contentEdgeInsets.bottom,
                                 right: self.raw_contentEdgeInsets.right + self.zt_contentEdgeInsets.right)
        self.contentEdgeInsets = inset
    }
}
