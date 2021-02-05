//
//  UserTokenManager.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//


import Foundation

public class UserTokenManager: NSObject
{
    private override init() { super.init() }
    
    static public var userToken: String? {
        let key = UserDefaultsKey.User.token.name
        let token = UserDefaults.standard.string(forKey: key)
        //#warning("Just for test")
        return token
    }
    
    static public var deviceToken: String? {
        let key = UserDefaultsKey.User.deviceToken.name
        let token = UserDefaults.standard.string(forKey: key)
        return token
    }
    
    static public func addDeviceToken(_ token: String) {
        let key = UserDefaultsKey.User.deviceToken.name
        UserDefaults.standard.set(token, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static public func addUserToken(_ token: String) {
        let key = UserDefaultsKey.User.token.name
        UserDefaults.standard.set(token, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static public func resetUserSession() {
        let tokenKey = UserDefaultsKey.User.token.name
        let deviceKey = UserDefaultsKey.User.deviceToken.name
        let userkey = UserDefaultsKey.User.currentUser.name
        UserDefaults.standard.removeObject(forKey: userkey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: deviceKey)
        UserDefaults.standard.synchronize()
    }
}
