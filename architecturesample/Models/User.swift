//
//  User.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

struct User {
    let email: String
    let registrationDate: Date
    let photoURL: URL?
    
    init(from firebaseUser: FirebaseUser) {
        email = firebaseUser.email!
        registrationDate = firebaseUser.metadata.creationDate!
        photoURL = firebaseUser.photoURL
    }
}
