//
//  AppLibraries.swift
//  Rakeb user
//
//  Created by prog_zidane on 5/10/20.
//  Copyright © 2020 Alamat. All rights reserved.
//

import UIKit
import Nuke

public class AppLibraries
{
    private init() { }
    
    static public func initLibraries(for application: UIApplication,
                              launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil)
    {
        enableKeyboardManager()
        setupNukeImageManager()
        ReachabilityManger.shared.checkReachability()
    }
    
    private static func enableKeyboardManager()
    {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private static func setupNukeImageManager()
    {
        DataLoader.sharedUrlCache.diskCapacity = 0
        let pipeline = ImagePipeline
        {
            guard let dataCache = try? DataCache(name: "com.Alamat.Rakeb-captain") else { return }
            dataCache.sizeLimit = 200 * 1024 * 1024
            $0.dataCache = dataCache
        }
        ImagePipeline.shared = pipeline
    }
}
