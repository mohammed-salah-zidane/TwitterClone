//
//  HomeRepo.swift
//  Data
//
//  Created by prog_zidane on 1/13/21.
//
import Moya
import RxSwift
import RxCocoa

public class HomeRepo {
    
    public let remoteDataSrc: HomeRemoteDataSrc
    public let localSrc: HomeLocalDataSrc
    private let disposeBag = DisposeBag()
    
    public init(remote: HomeRemoteDataSrc, localSrc: HomeLocalDataSrc) {
        self.remoteDataSrc = remote
        self.localSrc = localSrc
    }
    
    public func getFollowers(request: FollowersRequest) -> Single<FollowersResponse> {
        Single<FollowersResponse>.create { single in
            self.remoteDataSrc.followers(request: request).subscribe { response in
                self.save(users: response.users ?? []).subscribe {
                    single(.success(response))
                } onError: { error in
                    print("error")
                }.disposed(by: self.disposeBag)
                
            } onError: { error in
                self.getLocalFollwers { follwers in
                    single(.success(FollowersResponse(users: follwers, nextCursor: 0)))
                }
            }.disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
    
    @discardableResult
    public func save(users: [TwitterUser]) -> Completable {
        localSrc.save(users: users)
    }
    
    public func getLocalFollwers(_ completion:@escaping ([TwitterUser]) -> Void) {
        localSrc.all()
            .subscribe { followers in
                completion(followers?.reversed() ?? [])
            } onError: { error in
                print(error)
                completion([])
            }.disposed(by: disposeBag)
    }
    
    public func deleteAllFollowers() {
        localSrc.deleteAllFollowers()
    }
}

extension HomeRepo {
    public static func create() -> HomeRepo {
        let homeAPI: MoyaProvider<HomeAPI> = MoyaProviderBuilder.makeProvider()
        let homeRemoteDataSrc = HomeRemoteDataSrc(api: homeAPI)
        let localDataSrc = HomeLocalDataSrc(db: FollowerDao())
        return HomeRepo(remote: homeRemoteDataSrc, localSrc: localDataSrc)
    }
}
