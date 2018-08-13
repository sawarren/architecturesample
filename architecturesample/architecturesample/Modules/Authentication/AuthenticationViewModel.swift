//
//  AuthenticationViewModel.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import Foundation

class AuthenticationViewModel {
    
    // MARK: - Definitions -
    
    enum FormSubmissionError: Error {
        case validationFailed(reason: String)
        case registrationFailed(reason: String)
        case authenticationFailed(reason: String)
        
        var title: String {
            switch self {
            case .validationFailed: return "Validation Error"
            case .registrationFailed: return "Registration Error"
            case .authenticationFailed: return "Login Error"
            }
        }
        
        var localizedDescription: String {
            switch self {
            case .validationFailed(let reason): return reason
            case .registrationFailed(let reason): return reason
            case .authenticationFailed(let reason): return reason
            }
        }
        
        static let incompleteForm = FormSubmissionError.validationFailed(reason: "Please complete all of the fields in the form.")
        static let invalidEmail = FormSubmissionError.validationFailed(reason: "The email address you have provided is invalid.")
        static let invalidPassword = FormSubmissionError.validationFailed(reason: "Your password needs to be at least 6 characters long.")
        static let differentPasswords = FormSubmissionError.validationFailed(reason: "The passwords you have given don't match.")
    }
    
    enum FormOption: Int {
        case login = 0
        case register = 1
        
        var title: String {
            switch self {
            case .login: return "Login"
            case .register: return "Register"
            }
        }
        
        static var all: [FormOption] {
            return [.login, .register]
        }
    }
    
    // MARK: - Variables -
    
    fileprivate var service: AuthenticationService.Type!
    fileprivate var option: FormOption = .login
    
    fileprivate var email = ""
    fileprivate var password = ""
    fileprivate var repeatPassword = ""
    
    // MARK: - Initilisation -
    
    init(with service: AuthenticationService.Type) {
        self.service = service
    }
    
    // MARK: - Public API -

    var isLoginForm: Bool {
        return option == .login
    }
    
    var isRegistrationForm: Bool {
        return option == .register
    }
    
    var formOptionTitles: [String] {
        return FormOption.all.map{ $0.title }
    }
    
    var submitFormTitle: String {
        return option.title
    }
    
    func selectFormOption(for index: Int) {
        if let validOption = FormOption(rawValue: index) {
            self.option = validOption
        }
    }
    
    func update(email: String) {
        self.email = email
    }
    
    func update(password: String) {
        self.password = password
    }
    
    func update(repeatPassword: String) {
        self.repeatPassword = repeatPassword
    }
    
    func submitForm(completion: @escaping (User?, FormSubmissionError?) -> Void) {
        do {
            try validateForm()
        }
        catch {
            if let error = error as? FormSubmissionError {
                return completion(nil, error)
            }
        }
        
        switch option {
        case .login:
            service.login(with: email, and: password) { result in
                switch result {
                case .success(let user):
                    completion(user, nil)
                case .failed(let error):
                    completion(nil, .authenticationFailed(reason: error.localizedDescription))
                }
            }
        case .register:
            service.register(with: email, and: password) { result in
                switch result {
                case .success(let user):
                    completion(user, nil)
                case .failed(let error):
                    completion(nil, .registrationFailed(reason: error.localizedDescription))
                }
            }
        }
    }
    
    // MARK: - Private API -

    fileprivate func validateForm() throws {
        guard !email.isEmpty && !password.isEmpty else {
            throw FormSubmissionError.incompleteForm
        }
        guard email.isValidEmail else {
            throw FormSubmissionError.invalidEmail
        }
        if option == .register {
            guard !repeatPassword.isEmpty else {
                throw FormSubmissionError.incompleteForm
            }
            guard password.count > 5 else {
                throw FormSubmissionError.invalidPassword
            }
            guard password == repeatPassword else {
                throw FormSubmissionError.differentPasswords
            }
        }
    }
}


