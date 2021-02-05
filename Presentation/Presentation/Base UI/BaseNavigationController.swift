//
//  BaseNavigationController.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

public class BaseNavigationController: UINavigationController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setMainAppNavigationBarStyle()
    }
}

extension UINavigationController {
    
    fileprivate func setupTransparentNavigation() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.tintColor = UIColor.clear
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.clear
        self.navigationController?.navigationBar.barTintColor = UIColor.clear
    }
    
    public func updateNavigationTransparent() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationBar.barTintColor = .clear
        self.view.backgroundColor = .clear
        self.navigationBar.tintColor = .white
        self.navigationItem.hidesBackButton = true
        self.viewWillLayoutSubviews()
    }
}

extension UINavigationController {
    
    public func setMainAppNavigationBarStyle(){
        self.navigationBar.backgroundColor  = .white
        self.navigationBar.tintColor = Colors.primary.color
        self.navigationBar.barTintColor = .white
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.localizedFont(size: .size17, weight: .bold),NSAttributedString.Key.foregroundColor:UIColor.black ]
    }
    
    public func setBlueAppNavigationBarStyle(){
        self.navigationBar.backgroundColor  = Colors.primary.color
        self.navigationBar.tintColor = Colors.navBackground.color
        self.navigationBar.barTintColor = Colors.primary.color
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.localizedFont(size: .size17, weight: .bold),NSAttributedString.Key.foregroundColor:UIColor.white]
    }
}

extension UINavigationBar {
    public func setNavigationClear() {
        self.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
    }
}
