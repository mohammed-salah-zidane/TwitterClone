//
//  HomeVM.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeVM: ViewModel
{
    var isLoading: PublishSubject<Bool>
    var displayError: PublishSubject<String>
    var dataManager: DataManager
    var disposeBag: DisposeBag
    var hasFollowersFetched = BehaviorRelay<Bool>(value: false)
    var navigateToAuth = BehaviorRelay<Bool>(value: false)
    var refreshView = BehaviorRelay<Bool>(value: false)
    
    private var followers = [TwitterUser]()
    private var nextCursor: Int = -1
    
    private var accounts: [Account] {
        return UserSessionManager.shared.accounts ?? []
    }
    
    private var currentUser: User? {
        return UserSessionManager.shared.currentUser
    }
    
    private var menuItems : [String] {
        var items = accounts.map({"@\($0.user.screenName ?? "")"})
        items.append("Add new account".localized)
        items.append("Log out from all accounts".localized)
        return items
    }
    
    public init(
        dataManager: DataManager
    ) {
        self.disposeBag = DisposeBag()
        self.isLoading = .init()
        self.displayError = .init()
        self.dataManager = dataManager
    }
    
    func getFollowers() -> [TwitterUser]? {
        followers
    }
    
    func getNextCursor() -> Int {
        nextCursor
    }
    
    func getMenuItems() -> [String] {
        menuItems
    }
    
    func getCurrentUserName() -> String {
        currentUser?.screenName ?? ""
    }
    
    func selectItemInMenu(index: Int) {
        guard !(0..<accounts.count ~= index) else {
            selectAccount(index: index)
            return
        }
        
        guard index == menuItems.count - 1 else {
            self.navigateToAuth.accept(true)
            return
        }
        
        self.signOut()
    }
    
    private func selectAccount(index: Int) {
        let account = accounts[index]
        guard account.user.id != currentUser?.id else {
            return
        }
        UserSessionManager.shared.setCurrentAccount(account: account)
        dataManager.homeRepo.localSrc.deleteAllFollowers()
        self.refreshView.accept(true)
    }
    
    private func signOut() {
        dataManager.homeRepo.localSrc.deleteAllFollowers()
        UserSessionManager.shared.signOutAll()
        self.navigateToAuth.accept(true)
    }
}

extension HomeVM {
    func getFollowers(cursor: Int = -1) {
        let screenName = UserSessionManager.shared.currentUser?.screenName ?? ""
        self.nextCursor = cursor
        dataManager
            .homeRepo
            .getFollowers(request: FollowersRequest(screen_name: screenName, cursor: cursor, count: 10))
            .subscribe { [weak self] response in
                guard let self = self else {return}
                self.updateFollowersList(users: response.users ?? [])
                self.nextCursor = response.nextCursor ?? 0
                self.hasFollowersFetched.accept(true)
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
    
    private func updateFollowersList(users: [TwitterUser]) {
        guard nextCursor != -1 else {
            self.followers = users.unique(map: {$0.id})
            return
        }
        self.followers.append(contentsOf: users.unique(map: {$0.id}))
    }
}
