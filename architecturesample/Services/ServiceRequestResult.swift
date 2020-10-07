//
//  ServiceRequestResult.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

enum ServiceRequestResult<T> {
    case success(T)
    case failed(Error)
}
