//
//  HomeCoordinator.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

protocol ContentCoordinatorDelegate: class {
    func viewControllerDidLogOut(_ viewController: HomeViewController)
}

class ContentCoordinator: Coordinator {

    // MARK: - Variables -
    
    var window: UIWindow
    weak var delegate: ContentCoordinatorDelegate!
    
    var user: User!
    
    // MARK: - Initialisation -
    
    required init(with window: UIWindow) {
        self.window = window
    }
    
    convenience init(with window: UIWindow, and user: User) {
        self.init(with: window)
        self.user = user
    }
    
    // MARK: - Public API -
    
    func start() {
        showHomeViewController()
    }
    
    // MARK: - Private API -
    
    fileprivate func showHomeViewController() {
        let homeController = Storyboard.home.instantiate(viewController: HomeViewController.self)!
        homeController.model = HomeViewModel(with: user)
        homeController.delegate = self
        set(viewControllers: [homeController])
    }
}

// MARK: - HomeViewControllerDelegate -

extension ContentCoordinator: HomeViewControllerDelegate {
    func viewControllerDidLogOut(_ viewController: HomeViewController) {
        delegate.viewControllerDidLogOut(viewController)
    }
}
