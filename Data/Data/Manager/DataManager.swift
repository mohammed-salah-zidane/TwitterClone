//
//  DataManager.swift
//  Data
//
//  Created by prog_zidane on 12/13/20.
//

import Foundation

public class DataManager {
    public static func create() -> DataManager { DataManager() }

    public lazy var authRepo: AuthRepo = {
        AuthRepo.create()
    }()
    
    public lazy var homeRepo: HomeRepo = {
        HomeRepo.create()
    }()
}
