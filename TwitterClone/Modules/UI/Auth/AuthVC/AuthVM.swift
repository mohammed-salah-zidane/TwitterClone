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

extension AuthVM {
    func authRequest() {
        dataManager
            .authRepo
            .requestAuth()
            .subscribe { [weak self] result in
                switch result {
                case .success(let id):
                    self?.loadUser(userId: id)
                case .failure(let error):
                    self?.handleError(error: error)
                }
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func loadUser(userId: String) {
        self.isLoading.onNext(true)
        dataManager
            .authRepo
            .loadUser(with: userId)
            .subscribe { [weak self] result in
                self?.isLoading.onNext(false)
                switch result {
                case .success(let user):
                    UserSessionManager.shared.currentUser = user
                    UserSessionManager.shared.appendUser(user: user)
                    self?.auth.onNext(true)
                case .failure(let error):
                    self?.handleError(error: error)
                }
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
}
