//
//  AuthRepo.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//
import RxSwift
import RxCocoa
import Moya
import OAuthSwift
import SwiftyJSON

public class AuthRepo {
    
    public let remoteDataSrc: AuthRemoteDataSrc
    public lazy var oauthManager: OAuth1Swift = {
        OAuth1Swift(
            consumerKey: UserDefaultsKey.App.twitterConsumerKey.rawValue,
            consumerSecret: UserDefaultsKey.App.twitterConsumerSecret.rawValue,
            requestTokenUrl: ApiConstants.requestTokenURL,
            authorizeUrl: ApiConstants.authorizeURL,
            accessTokenUrl: ApiConstants.accessTokenURL)
    }()
    
    public init(remote: AuthRemoteDataSrc) {
        self.remoteDataSrc = remote
    }
    
    public func requestAccessToken() -> Single<String> {
        remoteDataSrc.requestAccessToken().map { response in
            return response.accessToken ?? ""
        }
    }
    
    public func requestAuth() -> Observable<Result<AuthResponse,NetworkError>> {
        return Observable<Result<AuthResponse,NetworkError>>
            .create { observer -> Disposable in
                self.oauthManager
                    .authorize(
                        withCallbackURL: ApiConstants.twitterCallBackURL
                    ) { (result) in
                        switch result {
                        case .success((let credentails, _, let paramters)):
                            do {
                                let paramtersJson = JSON(paramters)
                                var authResponse = try JSONDecoder().decode(AuthResponse.self, from: paramtersJson.rawData())
                                authResponse.oauthToken = credentails.oauthRefreshToken
                                observer.onNext(.success(authResponse))
                            }catch {
                                print(error)
                            }
                        case .failure:
                            break
                        }
                    }
                
                return Disposables.create()
            }
    }
}

extension AuthRepo {
    public static func create() -> AuthRepo {
        let homeAPI: MoyaProvider<AuthAPI> = MoyaProviderBuilder.makeProvider()
        let authRemoteDataSrc = AuthRemoteDataSrc(api: homeAPI)
        return AuthRepo(remote: authRemoteDataSrc)
    }
}
