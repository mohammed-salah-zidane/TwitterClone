//
//  TableViewDataSource.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import UIKit

class TableViewDataSource<Cell :UITableViewCell, ViewModel> : NSObject, UITableViewDataSource {
    
    private var items: [ViewModel]!
    var configureCell: (Cell, ViewModel, IndexPath) -> ()
    
    init(items :[ViewModel], configureCell: @escaping (Cell, ViewModel, IndexPath) -> ()) {
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeue() as? Cell {
            // for XIB Cell
            let item = self.items[indexPath.row]
            self.configureCell(cell, item, indexPath)
            return cell
        }else if let cell = tableView.dequeue() as? Cell {
            // for default cell
            let item = self.items[indexPath.row]
            self.configureCell(cell, item, indexPath)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
