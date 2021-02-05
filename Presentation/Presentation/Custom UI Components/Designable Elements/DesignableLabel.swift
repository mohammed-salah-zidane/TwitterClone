//
//  DesignableLabel.swift
//  Taqarir
//
//  Created by Marawan Turky on 1/31/19.
//  Copyright © 2019 Marawan Ahmed AbdelAziz Mohammed Torki. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableLabel: UILabel
{    
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
    public var topCorner: Bool = false
    {
        didSet
        {
            if topCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable
    public var borderWidth: CGFloat = 0.0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable
    public var borderColor: UIColor = .black {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable public var topInset: CGFloat = 0.0
    @IBInspectable public var leftInset: CGFloat = 0.0
    @IBInspectable public var bottomInset: CGFloat = 0.0
    @IBInspectable public var rightInset: CGFloat = 0.0
    
    public var insets: UIEdgeInsets
    {
        get
        {
            return UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        }
        set
        {
            topInset = newValue.top
            leftInset = newValue.left
            bottomInset = newValue.bottom
            rightInset = newValue.right
        }
    }
    
    override public func drawText(in rect: CGRect)
    {
        super.drawText(in: rect.inset(by: insets))
    }
    
    @IBInspectable
    public var localizedText: String {
        set {
            self.text = newValue
            self.adjustForLang()
        }
        get {
            return self.text ?? ""
        }
    }
    
    open func adjustForLang(){
//        if !LocalizationManager.isArabicLang()
//        {
//            textAlignment = NSTextAlignment.left
//            semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
//        }
//        else
//        {
//            textAlignment = NSTextAlignment.right
//            semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
//        }
    }
}

