//
//  AuthVM.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/5/21.
//

import Foundation

class AuthVM: ViewModel
{
    var isLoading: PublishSubject<Bool>
    var displayError: PublishSubject<String>
    var dataManager: DataManager
    var disposeBag: DisposeBag

    let auth = PublishSubject<Bool> ()
    
    public init(
        dataManager: DataManager
    ) {
        self.disposeBag = DisposeBag()
        self.isLoading = .init()
        self.displayError = .init()
        self.dataManager = dataManager
    }
}
