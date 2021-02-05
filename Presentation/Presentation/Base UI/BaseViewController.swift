//
//  BaseViewController.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit

public class BaseViewController: UIViewController
{
    public override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.setMainAppNavigationBarStyle()
        
    }
    
    public override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        Activity.stopAnimating()
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
}

