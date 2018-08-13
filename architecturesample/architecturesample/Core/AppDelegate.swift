//
//  AppDelegate.swift
//  architecturesample
//
//  Created by Steven Warren on 10/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        coordinator = AppCoordinator(with: window!)
        coordinator.start()
        configure()
        return true
    }
    
    func configure() {
        FirebaseApp.configure()
    }
}

