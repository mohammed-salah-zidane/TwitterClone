//
//  DesignableTextField.swift
//  Taqarir
//
//  Created by Marawan Turky on 1/30/19.
//  Copyright © 2019 Marawan Ahmed AbdelAziz Mohammed Torki. All rights reserved.
//

import UIKit

@IBDesignable public class DesignableTextField: UITextField{
    
    @IBInspectable public var SHADOW_COLOR: CGFloat = 155.0 / 255.0
    private var __maxLengths = [UITextField: Int]()
    
    @IBInspectable public var fireShadow: Bool = false
    {
        didSet
        {
            if fireShadow
            {
                layer.cornerRadius = 5.0
                layer.shadowColor = UIColor(red: SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
                layer.shadowOpacity = 0.5
                layer.shadowRadius = 10.0
                layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            }
            else
            {
                layer.cornerRadius = 0.0
                layer.shadowColor = UIColor.white.cgColor
                layer.shadowOpacity = 0.0
                layer.shadowRadius = 0.0
                layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            }
        }
    }
    
    @IBInspectable var maxLength: Int {
        get {
            guard let index = __maxLengths[self] else {
                return 200 // (global default-limit. or just, Int.max)
            }
            return index
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
    }
    
    
    // MARK: - Corner Radius
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable public var localizedPlaceholder: String {
        set {
            self.placeholder = newValue.localized
            self.adjustForLang()
        }
        get {
            return self.placeholder ?? ""
        }
    }
    
    @IBInspectable public var localizedText: String {
        set {
            self.text = newValue.localized
            self.adjustForLang()
        }
        get {
            return self.text ?? ""
        }
    }
    
    @IBInspectable public var setCountryCode: String {
        set {
            addCountryCode(code: newValue)
        }
        get {
            return ""
        }
    }
    
    @IBInspectable public var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable public var rightPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    private var _isRightViewVisible: Bool = true
    public var isRightViewVisible: Bool {
        get {
            return _isRightViewVisible
        }
        set {
            _isRightViewVisible = newValue
            updateView()
        }
    }
    
    public func updateView() {
        setLeftImage()
        setRightImage()
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?
                                                    placeholder! :
                                                    "", attributes:[NSAttributedString.Key.foregroundColor: tintColor!])
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text
        textField.text = String(text?.prefix(self.maxLength) ?? "")
    }
    
    public func setLeftImage() {
        leftViewMode = UITextField.ViewMode.always
        var view: UIView
        
        if let image = leftImage {
            let imageView = UIImageView(frame: CGRect(x: leftPadding, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + leftPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 15
                
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: 20))
        }
        
        leftView = view
    }
    
    public func setRightImage() {
        rightViewMode = UITextField.ViewMode.always
        
        var view: UIView
        
        if let image = rightImage, isRightViewVisible {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = tintColor
            
            var width = imageView.frame.width + rightPadding
            
            if borderStyle == UITextField.BorderStyle.none || borderStyle == UITextField.BorderStyle.line {
                width += 15
                
            }
            
            view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 20))
            view.addSubview(imageView)
            
        } else {
            view = UIView(frame: CGRect(x: 0, y: 0, width: rightPadding, height: 20))
        }
        
        rightView = view
    }
    
}

extension DesignableTextField
{
    public func addCountryCode(code: String)
    {
        self.placeholder = "5XX XXXXX"
        let codeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: self.frame.height))
        codeLabel.text = code
        codeLabel.textAlignment = .center
        codeLabel.font = UIFont.localizedFont(size: .size17, weight: .regular)
        codeLabel.textColor = UIColor.lightGray
        self.leftView = codeLabel
        self.leftViewMode = .always
    }
    
    public func adjustForLang()
    {
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
    
    public func setBottomLine(color: UIColor?)
    {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: frame.height - 1, width: frame.width, height: 1.0)
        bottomLine.backgroundColor = color?.cgColor
        borderStyle = .none
        layer.addSublayer(bottomLine)
    }
}

