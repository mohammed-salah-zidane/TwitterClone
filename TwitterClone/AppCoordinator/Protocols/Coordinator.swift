//
//  Coordinator.swift
//  RakebCaptain
//
//  Created by prog_zidane on 1/5/21.
//

import UIKit

protocol Coordinator: class {
    var auth: AuthNavigator { get }
    var home: HomeNavigator { get }
    var childCoordinators: [Coordinator] { get set }
    func backToRoot(coordinator: Coordinator)
    var navigationController: BaseNavigationController { get }
    func dismiss()
}
