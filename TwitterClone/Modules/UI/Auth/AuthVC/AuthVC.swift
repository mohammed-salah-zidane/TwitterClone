//
//  AuthVC.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/5/21.
//

import UIKit

class AuthVC: BaseWireframe<AuthVM, Coordinator> {

    //MARK:- Properties
    
    
    //MARK:- LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Ovverides
    override func bind(viewModel: AuthVM) {
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .darkContent
    }
}
