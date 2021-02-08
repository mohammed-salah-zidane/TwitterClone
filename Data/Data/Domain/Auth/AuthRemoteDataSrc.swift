//
//  AuthRemoteDataSrc.swift
//  Data
//
//  Created by prog_zidane on 2/8/21.
//

import Moya
import RxSwift

public class AuthRemoteDataSrc {
    
    let api: MoyaProvider<AuthAPI>
    
    init(api: MoyaProvider<AuthAPI>) {
        self.api = api
    }
    
    func requestAccessToken() -> Single<AccessTokenResponse> {
        api.rx.request(.requestAccessToken).mapItem()
    }
}
