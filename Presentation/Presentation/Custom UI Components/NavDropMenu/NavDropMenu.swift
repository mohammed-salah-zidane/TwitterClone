//
//  NavDropMenu.swift
//  Presentation
//
//  Created by prog_zidane on 2/9/21.
//

import UIKit
import BTNavigationDropdownMenu

public class NavDropMenu {
    
    public typealias selectedCallBack = ((Int) -> Void)
    
    private var menuView: BTNavigationDropdownMenu!
    
    
    public init() {
        
    }
    
    public func setup(
        title: String,
        items: [String],
        navigationItem: UINavigationItem,
        _ completion: @escaping selectedCallBack
    ) {
        self.menuView = BTNavigationDropdownMenu(title: title, items: items)
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            guard let self = self else {return}
            print("Did select item at index: \(indexPath)")
//            self.menuView.hide()
            completion(indexPath)
        }
        navigationItem.titleView = menuView
        menuView.navigationBarTitleFont = UIFont.localizedFont(weight: .bold)
        menuView.cellTextLabelFont = UIFont.localizedFont(weight: .regular)
        menuView.arrowTintColor = .black
    }
}
