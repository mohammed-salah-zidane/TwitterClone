//
//  UserSessionManager.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation
import OAuthSwift

public class UserSessionManager: NSObject
{
    // MARK: Init
    
    private override init() { super.init() }
    static public var shared = UserSessionManager()
    
    // MARK: Properties
    
    public var isSignedIn: Bool
    {
        guard currentUser != nil else { return false }
        return true
    }
    
    public var currentUser: User?
    {
        get {
            AppDefaults.value(forEncoded: UserDefaultsKey.User.currentUser)
        }
        
        set {
            AppDefaults.save(value: newValue, keyEncoded: UserDefaultsKey.User.currentUser)
        }
    }
    
    public var accounts: [Account]?
    {
        get {
            AppDefaults.value(forEncoded: UserDefaultsKey.User.multiUsers)
        }
        
        set {
            AppDefaults.save(value: newValue, keyEncoded: UserDefaultsKey.User.multiUsers)
        }
    }
    
    // MARK: Methods
    public func appendAccount(account: Account) {
        var newAccounts: [Account] = accounts ?? []
        newAccounts = newAccounts.filter({$0.user.id != account.user.id})
        newAccounts.append(account)
        AppDefaults.save(value: newAccounts, keyEncoded: UserDefaultsKey.User.multiUsers)
    }
    
    public func setCurrentAccount(account: Account) {
        self.currentUser = account.user
        UserTokenManager.addUserToken(account.accessToken)
    }
    
    public func signOutAll()
    {
        AppDefaults.clear()
    }
}
