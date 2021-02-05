//
//  iButton.swift
//  iControl
//
//  Created by Mohamed Shemy on Thu,13 Feb,2020.
//  Copyright © 2020 Mohamed Shemy. All rights reserved.
//

import UIKit

@IBDesignable
public class iButton: UIButton
{
    // MARK: - Properties
    
    @IBInspectable
    public var topCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if topCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            }
        }
    }
    
    @IBInspectable
    public var bottomCorner: Bool = false
        {
        didSet
        {
            if topCorner && bottomCorner
            {
                layer.maskedCorners = [.layerMinXMinYCorner,
                                       .layerMaxXMinYCorner,
                                       .layerMaxXMaxYCorner,
                                       .layerMinXMaxYCorner]
            }
            else if bottomCorner
            {
                layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            }
        }
    }
    
    @IBInspectable
    public var cornerRadius: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowColor: UIColor = UIColor.darkGray
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowOffsetWidth: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowOffsetHeight: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    @IBInspectable
    public var shadowRadius: CGFloat = 0.0
    {
        didSet
        {
            setNeedsLayout()
        }
    }
    
    // MARK: - Override
    
    override public func layoutSubviews()
    {
        super.layoutSubviews()
        layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        self.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowRadius = shadowRadius
    }
}
