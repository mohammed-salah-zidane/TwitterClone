//
//  Array+Extension.swift
//  Rakeb user
//
//  Created by prog_zidane on 12/27/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

extension Array where Element: Equatable {

    /// All indexes of specified item.
    ///
    /// - Parameter item: item to check.
    /// - Returns: an array with all indexes of the given item.
    public func indexes(of item: Element) -> [Int] {
        var indexes: [Int] = []
        for index in 0..<self.count {
            if self[index] == item {
                indexes.append(index)
            }
        }
        return indexes
    }
    
    /// Remove Dublicates
    public var unique: [Element] {
        // Thanks to https://github.com/sairamkotha for improving the method
         self.reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
    }
}
