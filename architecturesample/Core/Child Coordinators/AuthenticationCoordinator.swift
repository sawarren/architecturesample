//
//  AuthenticationCoordinator.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: class {
    func viewController(_ viewController: AuthenticationViewController, didAuthenticateUser user: User)
}

class AuthenticationCoordinator: Coordinator {
    
    // MARK: - Variables -
    
    var window: UIWindow
    weak var delegate: AuthenticationCoordinatorDelegate!
    
    // MARK: - Initialisation -
    
    required init(with window: UIWindow) {
        self.window = window
    }
    
    // MARK: - Public API -
    
    func start() {
        showAuthenticationViewController()
    }
    
    // MARK: - Private API -
    
    fileprivate func showAuthenticationViewController() {
        let authController = Storyboard.authentication.instantiate(viewController: AuthenticationViewController.self)!
        authController.model = AuthenticationViewModel(with: FirebaseAuthentication.self)
        authController.delegate = self
        set(viewControllers: [authController])
    }
}

// MARK: - AuthenticationViewControllerDelegate -

extension AuthenticationCoordinator: AuthenticationViewControllerDelegate {
    func viewController(_ viewController: AuthenticationViewController, didAuthenticateUser user: User) {
        delegate.viewController(viewController, didAuthenticateUser: user)
    }
}
