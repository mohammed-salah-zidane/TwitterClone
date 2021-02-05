//
//  AppDefaults.swift
//  Core
//
//  Created by prog_zidane on 12/12/20.
//

import Foundation

public struct AppDefaults {

    static public func save<T: Codable>(
            value: T,
            keyEncoded: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static public func value<T: Decodable>(
        forEncoded key: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode(T.self, from: data) as T
    }

    static public func saveArray<T: Codable>(
            value: [T],
        keyEncoded: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        save(value: try? PropertyListEncoder().encode(value), key: keyEncoded)
    }

    static public func valueArray<T: Decodable>(
            forEncoded key: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> [T]? {

        guard let data: Data = defaults.value(forKey: key.name) as? Data  else {
            return nil
        }

        return try? PropertyListDecoder().decode([T].self, from: data) as [T]
    }

    static public func save(
            value: Any?,
            key: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(value, forKey: key.name)
        defaults.synchronize()
    }

    static public func value<T>(
            for key: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) -> T? { defaults.value(forKey: key.name) as? T }

    static public func clearValue(
            for key: UserDefaultsKey.User,
            _ defaults: UserDefaults = UserDefaults.standard
    ) {
        defaults.setValue(nil, forKey: key.name)
        defaults.synchronize()
    }

    public static func clear(_ defaults: UserDefaults = UserDefaults.standard){
        let domain = Bundle.main.bundleIdentifier!
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count)
    }
}
