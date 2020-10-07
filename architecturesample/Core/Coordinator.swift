//
//  Coordinator.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

protocol Coordinator {
    var window: UIWindow { get set }
    
    init(with window: UIWindow)
    
    func start()
    func display(viewController: UIViewController)
    func set(viewControllers: [UIViewController])
}

extension Coordinator {
    func display(viewController: UIViewController) {
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        } else if let presentController = window.rootViewController {
            presentController.present(viewController, animated: true)
        }
    }
    
    func set(viewControllers: [UIViewController]) {
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.setViewControllers(viewControllers, animated: true)
        }
    }
}
