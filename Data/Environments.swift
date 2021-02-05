//
//  EnviromentsManager.swift
//  Core
//
//  Created by prog_zidane on 1/3/21.
//
import Foundation

enum Configuration: String {
    case development = "Debug"
    case production = "Release"
}

public class Environments {
    // MARK: Shared instance
    public static let shared = Environments()

    // MARK: Properties
    private let configurationKey = "Configuration"
    private let configurationDictionaryName = "Configuration"
    private let backendUrlKey = "backendUrl"

    let activeConfiguration: Configuration
    private let activeConfigurationDictionary: NSDictionary

    // MARK: Lifecycle
    init() {
        let bundle = Bundle(for: Environments.self)
        guard let rawConfiguration = bundle.object(forInfoDictionaryKey: configurationKey) as? String else {
            fatalError("Configuration Error")
        }
        
        guard let activeConfiguration = Configuration(rawValue: rawConfiguration) else {
            fatalError("Configuration Error")
        }
        
        guard let configurationDictionaryPath = bundle.path(forResource: configurationDictionaryName, ofType: "plist") else {
            fatalError("Configuration Error")
        }
        
        guard let configurationDictionary = NSDictionary(contentsOfFile: configurationDictionaryPath) else {
            fatalError("Configuration Error")
        }

        guard let activeEnvironmentDictionary = configurationDictionary[activeConfiguration.rawValue] as? NSDictionary else {
            fatalError("Configuration Error")
        }

        self.activeConfiguration = activeConfiguration
        self.activeConfigurationDictionary = activeEnvironmentDictionary
    }

    // MARK: Methods
    private func getActiveVariableValue<V>(forKey key: String) -> V {
        guard let value = activeConfigurationDictionary[key] as? V else {
            fatalError("No value satysfying requirements")
        }
        return value
    }

    func isRunning(in configuration: Configuration) -> Bool {
        return activeConfiguration == configuration
    }
    
    public var baseURL: URL {
        let backendUrlString: String = getActiveVariableValue(forKey: backendUrlKey)
        guard let backendUrl = URL(string: backendUrlString) else {
            fatalError("Backend URL missing")
        }
        return backendUrl
    }
}
