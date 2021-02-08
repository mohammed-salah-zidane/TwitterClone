//
//  Created by prog_zidane on 12/4/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

public class Pager {
    weak var tableView: PagedTableView!
    var loadMore: ((_ next: Int) -> Void)!
    var pageKeyType: PageKeyType = .paged
    var withScrollButton = false
    var withRefresher = false
    
    public class Builder {
        private let pager: Pager = Pager()

        public init() {}

        public func loadMore(_ block: @escaping (_ next: Int) -> Void) -> Builder {
            pager.loadMore = block
            return self
        }

        public func pageKeyType(type: PageKeyType) -> Builder {
            pager.pageKeyType = type
            return self
        }

        public func build() -> Pager {
            pager
        }
        
        public func withScrollButton() -> Builder {
            pager.withScrollButton = true
            return self
        }
        
        public func withRefresher() -> Builder {
            pager.withRefresher = true
            return self
        }
    }
    
    public func start(reset: Bool = true) {
        tableView.start(reset: reset)
        if withScrollButton {
            tableView.buildScrollButton()
        }
    }

    public func notifyItemsLoaded(count: Int) {
        tableView.notifyItemsLoaded(count: count)
    }
}
