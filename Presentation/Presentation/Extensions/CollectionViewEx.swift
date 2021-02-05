//
//  Refactored by Essam.
//

import UIKit

// MARK: UICollectionView

extension UICollectionView
{
    // MARK: Properties
    
    var visibleCurrentCellIndexPath: Int!
    {
        for cell in visibleCells
        {
            let indexPath = self.indexPath(for: cell)
            return indexPath?.row
        }
        return 0
    }
    
    // MARK: Methods
    
    func register<T>(cell: T.Type) where T: UICollectionViewCell
    {
        register(cell.nib, forCellWithReuseIdentifier: cell.cellIdentifier)
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell
    {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell
        else { fatalError("Error in cell") }
        return cell
    }
    
    func scrollToNextItem()
    {
        scrollToItem(at: IndexPath(row: visibleCurrentCellIndexPath + 1, section: 0), at: .right, animated: true)
    }
    
    func scrollToPreviousItem()
    {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset: CGFloat)
    {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
    
    func deselectAllItems(animated: Bool = false)
    {
        for indexPath in self.indexPathsForSelectedItems ?? [] {
            self.deselectItem(at: indexPath, animated: animated)
        }
    }
}

// MARK: UICollectionViewCell

extension UICollectionViewCell: IdentifiableCell
{
    public static var cellIdentifier: String
    {
        return "\(self)"
    }
}

extension UICollectionViewCell
{
    var collectionView: UICollectionView?
    {
        return self.next(of: UICollectionView.self)
    }
    
    var indexPath: IndexPath?
    {
        return self.collectionView?.indexPath(for: self)
    }
}
