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
    
    public static func create() -> HomeRepo {
        let homeAPI: MoyaProvider<HomeAPI> = MoyaProviderBuilder.makeProvider()
        let homeRemoteDataSrc = HomeRemoteDataSrc(api: homeAPI)
        return HomeRepo(remote: homeRemoteDataSrc)
    }
    
    public init(remote: HomeRemoteDataSrc) {
        self.remoteDataSrc = remote
    }
    
    public func getFollowers(request: FollowersRequest) -> Single<FollowersResponse> {
        remoteDataSrc.followers(request: request)
    }
}
