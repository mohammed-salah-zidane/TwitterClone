//
//  AuthVCBuilder.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/5/21.
//

import Foundation

class AuthVCBuilder {
    static func make(coordinator: Coordinator) -> AuthVC {
        let viewModel = AuthVM(dataManager: DataManager.create())
        let vc = AuthVC.make(from: .authentication, with: viewModel, coordinator: coordinator)
        return vc
    }
}
