//
//  Storyboard.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case authentication = "Authentication"
    case home = "Home"
    
    /// A convenient, type-safe way to instantiate a view controller from a storyboard.
    ///
    /// Requires that the view controllers storyboard identifier be identical to its class name.
    func instantiate<T: UIViewController>(viewController type: T.Type) -> T? {
        let identifier = String(describing: type)
        let storyboard = UIStoryboard(name: rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: identifier) as? T
    }
}
