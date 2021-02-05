//
//  UIButton+CenterContent.swift
//  Presentation
//
//  Created by prog_zidane on 1/27/21.
//

import UIKit

public extension UIButton {
    func centerContent(spacing: CGFloat, writingDirection: UIUserInterfaceLayoutDirection? = nil, padding: CGFloat? = nil) {
        var buttonWritingDirection: UIUserInterfaceLayoutDirection!
        if writingDirection == nil {
            buttonWritingDirection = UIApplication.shared.userInterfaceLayoutDirection
        }else {
            buttonWritingDirection = writingDirection
        }
        
        let insetAmount = spacing / 2
        let factor: CGFloat = buttonWritingDirection == .leftToRight ? 1 : -1
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount + (padding ?? 0), bottom: 0, right: insetAmount + (padding ?? 0))
    }
}

