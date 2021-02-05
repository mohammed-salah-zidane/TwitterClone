//
//  UICollectionView+EmptyMessage.swift
//  AlaDerbi
//
//  Created by prog_zidane on 11/2/20.
//  Copyright © 2020 Alamat Co. All rights reserved.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(_ message: String)
    {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.localizedFont(size: .size17, weight: .regular)
        messageLabel.sizeToFit()

        self.backgroundView = messageLabel
    }

    func restore()
    {
        self.backgroundView = nil
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

extension UICollectionViewFlowLayout {

    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return true
    }
}
