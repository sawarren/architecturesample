//
//  HomeViewModel.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    // MARK: - Variables -
    
    fileprivate lazy var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_GB")
        formatter.dateFormat = "LLLL, yyyy"
        return formatter
    }()
    
    fileprivate var user: User
    
    // MARK: - Initialisation -
    
    init(with user: User) {
        self.user = user
    }
    
    // MARK: - Public API -
    
    var emailAddress: String {
        return user.email
    }

    var registrationDateString: String {
        let dateString = formatter.string(from: user.registrationDate).lowercased()
        return "You have been a member since " + dateString
    }
    
    var profilePhotoData: Data? {
        // retrieve the image.
        return nil
    }
}
