//
//  UITableView+EmptyMessageExtension.swift
//  Rakeb user
//
//  Created by prog_zidane on 10/21/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UITableView {

    func setEmptyMessage(_ message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.localizedFont(size: .size14, weight: .medium)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }

    func restore()
    {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
    
    func setAcknowledgeMessage(count:Int,message:String)
    {
        if count == 0 {
            self.setEmptyMessage(message)
        } else {
            self.restore()
        }
    }
}
