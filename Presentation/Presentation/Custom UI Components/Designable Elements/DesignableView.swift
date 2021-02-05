//
//  DesignableView.swift
//  Taqarir
//
//  Created by Marawan Turky on 1/30/19.
//  Copyright © 2019 Marawan Ahmed AbdelAziz Mohammed Torki. All rights reserved.
//

import UIKit

@IBDesignable
public class DesignableView: UIView
{
    
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
    
    @IBInspectable
    /// Should the corner be as circle
    public var circleCorner: Bool {
        get {
            return min(bounds.size.height, bounds.size.width) / 2 == cornerRadius
        }
        set {
            cornerRadius = newValue ? min(bounds.size.height, bounds.size.width) / 2 : cornerRadius
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if fireShadow {
            installShadow(color: Colors.shadowColor.color, cornerRadius: cornerRadius)
        }
    }
} // end of class


extension UIView {
    
    public func installTopShadow(color: UIColor = Colors.shadowColor.color, cornerRadius: CGFloat = 12) {
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -4.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 5.0
    }
    
    public func installShadow(color: UIColor = Colors.shadowColor.color, cornerRadius: CGFloat = 12) {
        var shadowLayer: CAShapeLayer!
        shadowLayer = CAShapeLayer()
        shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 2, height: 3)
        shadowLayer.shadowOpacity = 0.8
        shadowLayer.shadowRadius = 6
        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
