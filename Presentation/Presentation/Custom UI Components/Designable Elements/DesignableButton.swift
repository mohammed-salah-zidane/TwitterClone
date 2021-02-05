//
//  DesignableButton.swift
//  Taqarir
//
//  Created by Marawan Turky on 1/30/19.
//  Copyright © 2019 Marawan Ahmed AbdelAziz Mohammed Torki. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableButton: UIButton
{
    @IBInspectable public var enableImageRightAligned: Bool = false
    @IBInspectable public var enableGradientBackground: Bool = false
    
    @IBInspectable public var gradientColor1: UIColor = UIColor.black
    @IBInspectable public var gradientColor2: UIColor = UIColor.white

    @IBInspectable public var fireShadow: Bool = false
    
    @IBInspectable
    public var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    public var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    public var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    override open func prepareForInterfaceBuilder() {
        
        super.prepareForInterfaceBuilder()
    }
    
    @IBInspectable
    public var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    @IBInspectable
    public var circleCorner: Bool
    {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable
    public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    
    @IBInspectable
    public var titleLeftPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.left = titleLeftPadding
        }
    }
    
    @IBInspectable
    public var titleRightPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.right = titleRightPadding
        }
    }
    
    @IBInspectable
    public var titleTopPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.top = titleTopPadding
        }
    }
    
    @IBInspectable
    public var titleBottomPadding: CGFloat = 0.0 {
        didSet {
            titleEdgeInsets.bottom = titleBottomPadding
        }
    }
    
    @IBInspectable
    public var imageLeftPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.left = imageLeftPadding
        }
    }
    
    @IBInspectable
    public var imageRightPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.right = imageRightPadding
        }
    }
    
    @IBInspectable
    public var imageTopPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.top = imageTopPadding
        }
    }
    
    @IBInspectable
    public var imageBottomPadding: CGFloat = 0.0 {
        didSet {
            imageEdgeInsets.bottom = imageBottomPadding
        }
    }
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        
        if enableImageRightAligned
        {
            if let imageView_temp = imageView {
                imageEdgeInsets.left = self.bounds.width - imageView_temp.bounds.width - imageRightPadding
            }
        }
        
        if enableGradientBackground
        {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [gradientColor1.cgColor, gradientColor2.cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
        
        if fireShadow {
            installShadow()
        }
    }
    
    @IBInspectable
    public var LocalizedTitle: String {
        set {
            self.setTitle(newValue.localized, for: .normal)
        }
        get {
            return self.titleLabel?.text ?? ""
        }
    }
    
    public func adjustForLang(){
//        if !LocalizationManager.isArabicLang()
//        {
//            titleLabel?.textAlignment = NSTextAlignment.left
//            semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
//        }
//        else
//        {
//            titleLabel?.textAlignment = NSTextAlignment.right
//            semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
//        }
    }
}
