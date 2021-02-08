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

    private var followers = [TwitterUser]()
    
    private var nextCursor: Int = -1
    
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
}

extension HomeVM {
    func getFollowers(cursor: Int = -1) {
        let screenName = UserSessionManager.shared.currentUser?.screenName ?? ""
        dataManager
            .homeRepo
            .getFollowers(request: FollowersRequest(screen_name: screenName, cursor: cursor, count: 10))
            .subscribe { [weak self] response in
                guard let self = self else {return}
                self.followers.append(contentsOf: response.users ?? [])
                self.nextCursor = response.nextCursor ?? 0
                self.hasFollowersFetched.accept(true)
            } onError: {[weak self] error in
                self?.handleError(error: error)
            }.disposed(by: disposeBag)
    }
}
