//
//  HomeVCBuilder.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeVCBuilder {
    static func make(coordinator: Coordinator) -> HomeVC {
        let viewModel = HomeVM(dataManager: DataManager.create())
        let vc = HomeVC.make(from: .home, with: viewModel, coordinator: coordinator)
        return vc
    }
}
