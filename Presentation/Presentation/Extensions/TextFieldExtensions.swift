//
//  TextFieldExtensions.swift
//  Rakeb user
//
//  Created by Essam Mohamed Fahmi on 8/29/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UITextField
{
    func checkMaxLength(maxLength: Int)
    {
        if let text = self.text, text.count > maxLength
        {
            self.deleteBackward()
        }
    }
}
