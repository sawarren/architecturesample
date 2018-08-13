//
//  AuthenticationService.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

protocol AuthenticationService {
    typealias RequestCompletion = (ServiceRequestResult<User>) -> Void
    static func register(with email: String, and password: String, completion: @escaping RequestCompletion)
    static func login(with email: String, and password: String, completion: @escaping RequestCompletion)
}
