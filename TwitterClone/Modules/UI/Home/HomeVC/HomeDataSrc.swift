//
//  HomeDataSrc.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeDataSrc: NSObject {
    var items: [TwitterUser] = []
    var onItemSelected: ((IndexPath) -> Void)? = nil
}

extension HomeDataSrc: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.setAcknowledgeMessage(count: items.count, message: "You don't have any followers yet".localized)
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as UserCell
        guard indexPath.row < items.count else {return cell}
        cell.setup(item: items[indexPath.row])
        return cell
    }
}

extension HomeDataSrc: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onItemSelected?(indexPath)
    }
}
