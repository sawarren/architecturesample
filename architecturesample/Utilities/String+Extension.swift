//
//  String+Extension.swift
//  architecturesample
//
//  Created by Steven Warren on 13/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let predicdate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicdate.evaluate(with: self)
    }
}
