//
//  HomeRemoteDataSrc.swift
//  Data
//
//  Created by prog_zidane on 1/13/21.
//
import Moya
import RxSwift

public class HomeRemoteDataSrc {
    
    let api: MoyaProvider<HomeAPI>
    
    init(api: MoyaProvider<HomeAPI>) {
        self.api = api
    }
    
    func followers(request: FollowersRequest) -> Single<FollowersResponse> {
        api.rx.request(.getFollowers(request: request)).mapItem()
    }
}
