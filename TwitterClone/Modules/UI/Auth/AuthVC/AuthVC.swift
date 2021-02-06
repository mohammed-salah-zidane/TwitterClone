//
//  AuthVC.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/5/21.
//

import UIKit
import TwitterKit

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
    
    //MARK:- Ovverides
    override func bind(viewModel: AuthVM) {
        
    }
    
    //MARK:- Actions
    @IBAction func logingTapped(_ sender: Any) {
        
    }
}
