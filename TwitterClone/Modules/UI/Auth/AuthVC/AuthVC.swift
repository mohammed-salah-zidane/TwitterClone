//
//  AuthVC.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/5/21.
//

import UIKit
import TwitterKit

class AuthVC: BaseWireframe<AuthVM, Coordinator> {
    
    //MARK:- LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar = true
    }
    
    //MARK:- Ovverides
    override func bind(viewModel: AuthVM) {
        viewModel
            .auth
            .asDriver(onErrorJustReturn: false)
            .drive(onNext:{ [weak self] state in
                guard let self = self else {return}
                guard state else {return}
                NotifiyMessage.shared.notify(message: "Auth Success")
            }).disposed(by: disposeBag)
    }
    
    //MARK:- Actions
    @IBAction func logingTapped(_ sender: Any) {
        viewModel.authRequest()
    }
}
