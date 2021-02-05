//
//  AppDelegate.swift
//  RakebCaptain
//
//  Created by prog_zidane on 12/12/20.
//

import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appCoordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        AppLibraries.initLibraries(for: application, launchOptions: launchOptions)
        appCoordinator.start()
        return true
    }
}

