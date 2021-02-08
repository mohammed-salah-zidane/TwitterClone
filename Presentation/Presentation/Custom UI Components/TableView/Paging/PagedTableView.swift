//
//  Created by prog_zidane on 12/4/20.
//  Copyright © 2020 Alamat. All rights reserved.
//
import UIKit
import SnapKit

public class PagedTableView: UITableView {
    weak open var pagedDelegate: UITableViewDelegate?
    weak open var pagedDataSource: UITableViewDataSource?
    
    private var page: Int = -1
    private var isLoading = false
    private var started = true
    private var hasMoreItems = true
    
    lazy var  refresher: UIRefreshControl = {
        var refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refresh.tintColor = Colors.primary.color
        refresh.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        return refresh
    }()
    
    enum ScrollButtonState {
        case visible
        case hidden
    }
    
    private var scrollButtonState: ScrollButtonState = .hidden{
        didSet {
            switch self.scrollButtonState {
            case .hidden:
                self.scrollButton.isHidden = true
            case .visible:
                self.scrollButton.isHidden = false
            }
        }
    }
    
    private lazy var scrollButton: DesignableButton = {
        let button = DesignableButton(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        button.setImage(#imageLiteral(resourceName: "scrollButton"), for: .normal)
        button.setTitle("", for: .normal)
        button.circleCorner = false
        button.addTapGestureRecognizer {[weak self] in
            guard let self = self else {return}
            self.scrollToTop()
            self.scrollButtonState = .hidden
        }
        return button
    }()
    
    public weak var pager: Pager! {
        didSet {
            pager.tableView = self
            if pager.withRefresher {
               addSubview(refresher)
            }
        }
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
    }
    
    @objc func refresh(_ sender: AnyObject) {
        invalidate()
    }
}

extension PagedTableView {
    
    public func buildScrollButton() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.scrollButton.translatesAutoresizingMaskIntoConstraints = false
            UIApplication.getTopViewController()?.view.addSubview(self.scrollButton)
            self.scrollButton.snp.makeConstraints { (make) in
                make.width.height.equalTo(40)
                make.width.width.equalTo(40)
                make.bottom.equalTo(self).inset(25)
                make.trailing.equalTo(self).inset(30)
            }
            self.scrollButtonState = .hidden
        }
    }
    
    public func invalidate() {
        start(reset: true)
    }
    
    public func start(reset: Bool = true) {
        setup()
        started = true
        // reset page number if refresh
        if reset {
            page = -1
            hasMoreItems = true
        }
        
        // return if already loading or dont have any more data
        guard hasMoreItems, !isLoading else {
            return
        }
        
        // start loading
        isLoading = true
        
        addLoadingFooter()
        
        pager.loadMore(calculateNext())
    }
    
    private func calculateNext() -> Int {
        switch pager.pageKeyType {
        case .positional:
            return lastRow() + 1
        case .paged:
            return page
        }
    }
    
    func notifyItemsLoaded(count: Int) {
        if count == 0 {
            hasMoreItems = false
            tableFooterView = nil
        }
        isLoading = false
        refreshControl?.endRefreshing()
        refresher.endRefreshing()
        page = count
        reloadData()
        hidLoading()
        toggleScrollButton()
    }
    
    private func addLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        spinner.frame = CGRect(
            x: CGFloat(0),
            y: CGFloat(0),
            width: bounds.width,
            height: CGFloat(44)
        )
        
        tableFooterView = spinner
        tableFooterView?.isHidden = false
    }
    
    public func hidLoading() {
        isLoading = false
        tableFooterView = nil
    }
}


extension PagedTableView: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pagedDataSource?.tableView(tableView, numberOfRowsInSection: section) ?? 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        pagedDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        pagedDataSource?.numberOfSections?(in: tableView) ?? 1
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        pagedDelegate?.tableView?(tableView, estimatedHeightForRowAt: indexPath) ?? estimatedRowHeight
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pagedDelegate?.tableView?(tableView, willDisplay: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        pagedDelegate?.tableView?(tableView, didEndDisplaying: cell, forRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        pagedDelegate?.tableView?(tableView, viewForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pagedDelegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        pagedDataSource?.tableView?(tableView, titleForHeaderInSection: section)
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        pagedDelegate?.tableView?(tableView, heightForHeaderInSection: section) ?? CGFloat(0)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        pagedDelegate?.tableView?(tableView, heightForRowAt: indexPath) ?? rowHeight
    }
}

extension PagedTableView {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        toggleScrollButton()
        checkForLoadMore()
    }
    
    func checkForLoadMore() {
        guard started else {
            return
        }
        
        guard let indexPath = self.visibleCells.last?.indexPath else {
            return
        }
        
        guard hasMoreItems && indexPath.row == lastRow() - 1 else {
            return
        }
        
        start(reset: false)
    }
    
    func toggleScrollButton() {
        
        guard let indexPath = self.visibleCells.last?.indexPath else {
            return
        }
        
        if indexPath.row == lastRow() {
            self.scrollButtonState = .visible
        }else {
            self.scrollButtonState = .hidden
        }
        
        guard isFirstCellVisible() else {
            self.scrollButtonState = .visible
            return
        }
        self.scrollButtonState = .hidden
    }
    
    func isFirstCellVisible() -> Bool {
        for indexPath in indexPathsForVisibleRows ?? [] {
            if validateForFirstCell(indexPath: indexPath) {
                return true
            }
        }
        return false
    }
    
    func validateForFirstCell(indexPath: IndexPath) -> Bool {
        indexPath.row == 0 && indexPath.section == 0
    }
    
    func validateForFirstTwoCells(indexPath: IndexPath) -> Bool {
        indexPath.row <= 1 && indexPath.section == 0
    }
    
    func numberOfItems() -> Int {
        var numbers = 0
        for section in 0..<numberOfSections {
            numbers += numberOfRows(inSection: section)
        }
        return numbers
    }
    
    func lastRow() -> Int {
        let lastSectionIndex = numberOfSections - 1
        return numberOfRows(inSection: lastSectionIndex) - 1
    }
}

public enum PageKeyType {
    case positional
    case paged
}


