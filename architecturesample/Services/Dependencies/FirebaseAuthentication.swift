//
//  FirebaseAuthentication.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import FirebaseAuth

typealias FirebaseUser = FirebaseAuth.User

class FirebaseAuthentication: AuthenticationService {
    
    private init() {}
    
    // MARK: - Public API -

    static func register(with email: String, and password: String, completion: @escaping RequestCompletion) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failed(error))
            } else if let firebaseUser = result?.user {
                let user = User(from: firebaseUser)
                completion(.success(user))
            }
        }
    }
    
    static func login(with email: String, and password: String, completion: @escaping RequestCompletion) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failed(error))
            } else if let firebaseUser = result?.user {
                let user = User(from: firebaseUser)
                completion(.success(user))
            }
        }
    }
}
