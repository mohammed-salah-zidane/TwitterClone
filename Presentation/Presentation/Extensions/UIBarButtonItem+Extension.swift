//
//  UIBarButtonItem+Extension.swift
//  Rakeb user
//
//  Created by prog_zidane on 11/25/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    func createButton(with title: String) -> UIBarButtonItem {
        let cancelButton = UIButton.init(type: UIButton.ButtonType.custom)
        cancelButton.setTitle(title, for: .normal)
        cancelButton.sizeToFit()
        cancelButton.backgroundColor = UIColor.clear
        cancelButton.setTitleColor(UIColor.white, for: .normal)
        cancelButton.titleLabel?.font = UIFont.localizedFont(size: .size16, weight: .regular)
        return UIBarButtonItem.init(customView: cancelButton)
    }
}
