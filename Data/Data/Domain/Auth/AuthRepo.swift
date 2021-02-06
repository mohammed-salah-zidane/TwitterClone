//
//  AuthRepo.swift
//  Data
//
//  Created by prog_zidane on 1/5/21.
//
import RxSwift
import RxCocoa
import TwitterKit

public class AuthRepo {
    
    public init() {
        
    }
    
    public func requestAuth() -> Observable<Result<String,NetworkError>> {
        return Observable<Result<String,NetworkError>>
            .create { observer -> Disposable in
                TWTRTwitter
                    .sharedInstance()
                    .logIn { (session, error) in
                        guard error == nil else {
                            observer.onNext(.failure(.errorMessage(text: error?.asAFError?.localizedDescription ?? "Failed to auth")))
                            return
                        }
                        guard let userId = session?.userID, !userId.isEmpty else {
                            return
                        }
                        observer.onNext(.success(userId))
                    }
                
                return Disposables.create()
            }
    }
    
    public func loadUser(with id: String) -> Observable<Result<User,NetworkError>> {
        return Observable<Result<User,NetworkError>>
            .create { observer -> Disposable in
                let twitterClient = TWTRAPIClient(userID: id)
                twitterClient.loadUser(withID: id) {(user, error) in
                    guard error == nil else {
                        observer.onNext(.failure(.errorMessage(text: error?.asAFError?.localizedDescription ?? "Failed to auth")))
                        return
                    }
                    let currentUser = User(id: id, avatar: user?.profileImageURL, name: user?.name, screenName: user?.screenName)
                    observer.onNext(.success(currentUser))
                }
                return Disposables.create()
            }
    }
}

extension AuthRepo {
    public static func create() -> AuthRepo {
        AuthRepo()
    }
}
