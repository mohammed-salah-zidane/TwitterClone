//
//  UserSessionManager.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import Foundation

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
    
    public var users: [User]?
    {
        get {
            AppDefaults.value(forEncoded: UserDefaultsKey.User.multiUsers)
        }
        
        set {
            AppDefaults.save(value: newValue, keyEncoded: UserDefaultsKey.User.multiUsers)
        }
    }
    
    // MARK: Methods
    
    public func appendUser(user: User) {
        self.users?.append(user)
    }
    
    public func removeUser(user: User) {
        let filteredUsers = self.users?.filter({$0.id != user.id})
        self.users = filteredUsers
    }
    
    public func signOut()
    {
        guard currentUser != nil else { return }
        currentUser = nil
    }
}
