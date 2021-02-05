//
//  UibuttonLoader.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import UIKit
import NVActivityIndicatorView

extension UIButton {
    public func loadingIndicator(show:Bool) {
        let tag = 808404
        if show {
            self.isEnabled = false
            let buttonHeight = self.bounds.size.height
            let buttonWidth = self.bounds.size.width
            let frame = CGRect(x: buttonWidth/2,y: buttonHeight/2,width: buttonWidth > buttonHeight ? buttonHeight/2 : buttonWidth/2 ,height: buttonWidth > buttonHeight ? buttonHeight/2 : buttonWidth/2)
            let indicator = NVActivityIndicatorView(frame: frame,type: .ballPulseSync,color: self.titleLabel?.textColor, padding: 0.0)
            indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
            indicator.tag = tag
            indicator.backgroundColor = self.backgroundColor
            self.addSubview(indicator)
            indicator.startAnimating()
            self.alpha = 0.7
        } else {
            self.isEnabled = true
            self.alpha = 1.0
            if let indicator = self.viewWithTag(tag) as? NVActivityIndicatorView {
                indicator.stopAnimating()
                indicator.removeFromSuperview()
            }
        }
    }
}
