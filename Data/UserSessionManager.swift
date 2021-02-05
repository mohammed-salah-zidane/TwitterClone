//
//  UserSessionManager.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import CoreLocation

public class UserSessionManager: NSObject
{
    // MARK: Init
    
    private override init() { super.init() }
    static public var shared = UserSessionManager()
    
    // MARK: Properties
    
    public var userLocation: PickPoint?{
        get {
            AppDefaults.value(forEncoded: UserDefaultsKey.User.userLocation)
        }
        set {
            AppDefaults.save(value: newValue, keyEncoded: UserDefaultsKey.User.userLocation)
        }
    }
    
    public var isSignedIn: Bool
    {
        guard UserTokenManager.userToken != nil else { return false }
        return true
    }
    
    public var captain: Captain?
    {
        get {
            AppDefaults.value(forEncoded: UserDefaultsKey.User.captain)
        }
        set {
            AppDefaults.save(value: newValue, keyEncoded: UserDefaultsKey.User.captain)
        }
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
    
    // MARK: Methods
    
    public func signOut()
    {
        guard captain != nil else { return }
        currentUser = nil
        captain = nil
        removeUserData()
    }
    
    // MARK: Private Methods
    
    private func removeUserData()
    {
        UserTokenManager.resetUserSession()
    }
}
