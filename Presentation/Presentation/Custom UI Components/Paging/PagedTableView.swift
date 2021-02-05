//
//  Created by prog_zidane on 12/4/20.
//  Copyright © 2020 Alamat. All rights reserved.
//
import UIKit

public class PagedTableView: UITableView {
    weak open var pagedDelegate: UITableViewDelegate?
    weak open var pagedDataSource: UITableViewDataSource?

    private var page: Int = 1
    private var isLoading = false
    private var started = true
    private var hasMoreItems = true
    
    public weak var pager: Pager! {
        didSet {
            pager.tableView = self
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
}

extension PagedTableView {
    
    public func invalidate() {
        start(reset: true)
    }

    public func start(reset: Bool = true) {
        setup()
        started = true
        // reset page number if refresh
        if reset {
            page = 1
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
        page = self.page + 1
        reloadData()
        hidLoading()
    }

    private func addLoadingFooter() {
        let spinner = UIActivityIndicatorView(style: .medium)
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
        if !started {
            return UITableViewCell()
        }
        if hasMoreItems && indexPath.row == lastRow() {
            start(reset: false)
            return UITableViewCell()
        }
        return pagedDataSource?.tableView(tableView, cellForRowAt: indexPath) ?? UITableViewCell()
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

    func lastRow() -> Int {
        let lastSectionIndex = numberOfSections - 1
        return numberOfRows(inSection: lastSectionIndex) - 1
    }
}

public enum PageKeyType {
    case positional
    case paged
}


