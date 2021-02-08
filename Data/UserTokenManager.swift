//
//  UserTokenManager.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import RxSwift

public class UserTokenManager: NSObject
{
    private override init() { super.init() }
    
    static public var accessToken: String? {
        let key = UserDefaultsKey.User.token.name
        let token = UserDefaults.standard.string(forKey: key)
        return token
    }
    
    static public func addUserToken(_ token: String) {
        let key = UserDefaultsKey.User.token.name
        UserDefaults.standard.set(token, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static public func resetUserSession() {
        AppDefaults.clearValue(for: .token)
    }
}
