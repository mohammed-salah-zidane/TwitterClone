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

//MARK:- Network
extension AuthVM {
    func authRequest() {
        dataManager
            .authRepo
            .requestAuth()
            .subscribe { [weak self] result in
                switch result {
                case .success(let auth):
                    let user = User(id: auth.userID, screenName: auth.screenName)
                    self?.requestNewAccess(user: user)
                case .failure(let error):
                    self?.handleError(error: error)
                }
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    func requestNewAccess(user: User) {
        self.isLoading.onNext(true)
        dataManager
            .authRepo
            .requestAccessToken()
            .subscribe(onSuccess: {[weak self] token in
                self?.isLoading.onNext(false)
                UserTokenManager.addUserToken(token)
                let account = Account(user: user, accessToken: token)
                UserSessionManager.shared.appendAccount(account: account)
                UserSessionManager.shared.setCurrentAccount(account: account)
                self?.auth.onNext(true)
            }, onError: {[weak self] error in
                self?.handleError(error: error)
            }).disposed(by: disposeBag)
    }
}
