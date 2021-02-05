//
//  UIViewController+Ex.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

extension UIViewController
{
    public typealias AlertCompletionHandler = () -> Void

    public func showAlert(
        title: String = "",
        message: String,
        addCancelAction: Bool = true,
        okayHandler: AlertCompletionHandler? = nil,
        cancelHandler: AlertCompletionHandler? = nil,
        okTitle: String = "Okay".localized,
        cancelTitle: String = "Cancel".localized
    ) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (alertAction) in
            if let okayHandler = okayHandler {
                okayHandler()
            }
        }))
        
        if (addCancelAction){
            alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { alert in
                if let okayHandler = cancelHandler {
                    okayHandler()
                }
            }))
        }

        DispatchQueue.main.async(execute: { [weak self] in
            self?.present(alert, animated: true, completion: nil)
        })
    }
    
    public func loadActivity(_ loading: Bool)
    {
        loading ? Activity.startAnimating() : Activity.stopAnimating()
    }
    
    public func setupBackButton() {
        navigationController?.navigationBar.tintColor = .appDarkBlue
        self.navigationController?.navigationBar.backIndicatorImage = #imageLiteral(resourceName: "backBlue")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "backBlue")
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
