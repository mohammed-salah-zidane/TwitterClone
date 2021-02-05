//
//  UITableView+Scrolling.swift
//  Rakeb user
//
//  Created by prog_zidane on 12/31/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

extension UITableView {

    public func scrollToTop(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: animated)
            }
        }
    }
    
    public func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {
                self.scrollToRow(at: IndexPath(row: row - 1, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }

    public func scrollToRowNumber(index: Int, animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let totalRows = self.numberOfRows(inSection: section - 1)
            if totalRows > 0 && index < totalRows {

                self.scrollToRow(at: IndexPath(row: index, section: section - 1), at: .bottom, animated: animated)
            }
        }
    }

    public func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

