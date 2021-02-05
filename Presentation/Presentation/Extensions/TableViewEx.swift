//
//  Refactored by Essam Mohamed Fahmi.
//

import UIKit

public protocol IdentifiableCell: class
{
    static var cellIdentifier: String { get }
}

extension UITableViewCell: IdentifiableCell
{
    static public var cellIdentifier: String
    {
        return "\(self)"
    }
}

public extension UITableViewCell
{
    var tableView: UITableView?
    {
        return self.next(of: UITableView.self)
    }
    
    var indexPath: IndexPath?
    {
        return self.tableView?.indexPath(for: self)
    }
}

public extension UITableView
{
    var visibleCellsHeight: CGFloat
    {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        return visibleCells.reduce(0) { $0 + $1.frame.height }
    }
    
    func register<T>(cell: T.Type) where T: UITableViewCell
    {
        register(cell.nib, forCellReuseIdentifier: cell.cellIdentifier)
    }
    
    func dequeue<Cell: UITableViewCell>() -> Cell
    {
        guard let cell = dequeueReusableCell(with: Cell.self) else { fatalError("Error in cell") }
        return cell
    }
    
    private func dequeueReusableCell<T: IdentifiableCell>(with cell: T.Type) -> T?
    {
        return dequeueReusableCell(withIdentifier: cell.cellIdentifier) as? T
    }
    
    func isCellVisible(section:Int, row: Int) -> Bool
    {
        guard let indexes = self.indexPathsForVisibleRows else
        {
            return false
        }
        
        return indexes.contains {$0.section == section && $0.row == row }
    }
    
    func hideEmptyCells()
    {
        tableFooterView = UIView()
    }
    
    func update(action: (() -> ())? = nil) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0) { [weak self] in
                guard let self = self else {
                    return
                }
                self.beginUpdates()
                action?()
                self.endUpdates()
                self.layoutIfNeeded()
            }
        }
    }
}
