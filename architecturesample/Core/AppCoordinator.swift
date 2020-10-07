//
//  AppCoordinator.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {

    // MARK: - Variables -
    
    var window: UIWindow
    var childCoordinators = [CoordinatorKey : Coordinator]()
    
    fileprivate var user: User?
    fileprivate var isUserAuthenticated: Bool {
        return user != nil
    }
    
    // MARK: - Initialisation -

    required init(with window: UIWindow) {
        self.window = window
        self.window.rootViewController = UINavigationController()
        self.window.makeKeyAndVisible()
    }

    // MARK: - Public API -
    
    func start() {
        if isUserAuthenticated {
            showContent()
        } else {
            showAuthentication()
        }
    }
    
    // MARK: - Private API -
    
    fileprivate func showAuthentication() {
        let authCoordinator = AuthenticationCoordinator(with: window)
        authCoordinator.delegate = self
        authCoordinator.start()
        childCoordinators[.authentication] = authCoordinator
    }
    
    fileprivate func showContent() {
        guard let user = user else { return }
        let contentCoordinator = ContentCoordinator(with: window, and: user)
        contentCoordinator.delegate = self
        contentCoordinator.start()
        childCoordinators[.content] = contentCoordinator
    }
}

// MARK: - AuthenticationCoordinatorDelegate -

extension AppCoordinator: AuthenticationCoordinatorDelegate {
    func viewController(_ viewController: AuthenticationViewController, didAuthenticateUser user: User) {
        childCoordinators[.authentication] = nil
        self.user = user
        showContent()
    }
}

// MARK: - ContentCoordinatorDelegate -

extension AppCoordinator: ContentCoordinatorDelegate {
    func viewControllerDidLogOut(_ viewController: HomeViewController) {
        childCoordinators[.content] = nil
        self.user = nil
        showAuthentication()
    }
}
