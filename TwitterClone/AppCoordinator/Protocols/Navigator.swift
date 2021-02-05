//
//  Navigator.swift
//  RakebCaptain
//
//  Created by prog_zidane on 1/5/21.
//

import UIKit

enum NavigatorTypes {
    case push
    case present
    case presentWithNavigation
    case root
}

protocol Navigator {
    associatedtype Destination
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController
    init(coordinator: Coordinator)
    var coordinator: Coordinator { get }
    func navigate(to destination: Destination, with navigationType: NavigatorTypes)
    var rootViewController: UIViewController { get }
}

extension Navigator {
    func navigate(to destination: Destination,
                  with navigationType: NavigatorTypes = .push) {
        let viewController = self.viewController(for: destination, coordinator: coordinator)
        switch navigationType {
        case .push:
            coordinator.navigationController.pushViewController(viewController, animated: true)
        case .present:
            viewController.modalPresentationStyle = .overCurrentContext
            coordinator.navigationController.present(viewController, animated: true, completion: nil)
        case .presentWithNavigation:
            let newVC = self.viewController(for: destination, coordinator: coordinator)
            coordinator.navigationController.setViewControllers([newVC], animated: true)
            //coordinator.navigationController.present(coordinator.navigationController, animated: true, completion: nil)
        case .root:
            coordinator.navigationController.setViewControllers([viewController], animated: true)
        }
    }
}


