//
//  AppCoordinator.swift
//  RakebCaptain
//
//  Created by prog_zidane on 1/5/21.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator] = [Coordinator]()
        
    let window: UIWindow
    
    lazy var auth: AuthNavigator = {
        return .init(coordinator: self)
    }()
    
    lazy var navigationController: BaseNavigationController = {
        let nav  = BaseNavigationController()
        nav.delegate = self
        return nav
    }()
        
    private var isLogedIn: Bool!
    {
        return UserSessionManager.shared.isSignedIn
    }

    init(window: UIWindow = UIWindow()) {
        self.window = window
    }
    
    func start() {
        setupAuth()
    }
    
    func setupAuth() {
        let nav = BaseNavigationController()
        nav.delegate = self
        navigationController = nav
        navigationController.viewControllers = [auth.rootViewController]
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
}

// MARK: UINavigationControllerDelegate
extension AppCoordinator: UINavigationControllerDelegate
{
    func dismiss() {
        self.navigationController.popViewController(animated: true)
        self.navigationController.dismiss(animated: true, completion: nil)
    }
    
    func backToRoot(coordinator: Coordinator) {
        
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backButtonTitle = " "
    }
}
