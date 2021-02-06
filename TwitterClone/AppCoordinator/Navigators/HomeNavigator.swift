//
//  HomeNavigator.swift
//  TwitterClone
//
//  Created by prog_zidane on 2/7/21.
//

import Foundation

class HomeNavigator: Navigator {
    var coordinator: Coordinator
    
    enum Destination {
        case home
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    var rootViewController: UIViewController {
        return viewController(for: .home, coordinator: coordinator)
    }
    
    func viewController(for destination: Destination, coordinator: Coordinator) -> UIViewController {
        switch destination {
        case .home:
            return HomeVCBuilder.make(coordinator: coordinator)
        }
    }
}
