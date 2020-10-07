//
//  ViewController.swift
//  architecturesample
//
//  Created by Steven Warren on 10/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

protocol AuthenticationViewControllerDelegate: class {
    func didAuthenticate(_ user: User)
}

class AuthenticationViewController: UIViewController {
    
    // MARK: - Variables -
    
    @IBOutlet fileprivate weak var optionSegmentedControl: UISegmentedControl!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var repeatPasswordStackView: UIStackView!
    @IBOutlet fileprivate weak var repeatPasswordTextField: UITextField!
    @IBOutlet fileprivate weak var submitButton: UIButton!
    
    var model: AuthenticationViewModel!
    weak var delegate: AuthenticationViewControllerDelegate!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        setupView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Private API -
    // MARK: Setup
    
    fileprivate func setupView() {
        setupOptionSegmentedControl()
        setupSubmitButton()
        setupTextFields()
        clearForm()
    }
    
    fileprivate func setupOptionSegmentedControl() {
        for (index, title) in model.formOptionTitles.enumerated() {
            if index < 2 {
                optionSegmentedControl.setTitle(title, forSegmentAt: index)
            } else {
                optionSegmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }
        }
        
        optionSegmentedControl.selectedSegmentIndex = 0
        model.selectFormOption(for: optionSegmentedControl.selectedSegmentIndex)
        
        optionSegmentedControl.layer.cornerRadius = 4.0
        optionSegmentedControl.layer.shadowOffset = CGSize(width: 5, height: 10)
        optionSegmentedControl.layer.shadowColor = UIColor.white.cgColor
        optionSegmentedControl.layer.shadowOpacity = 0.1
        optionSegmentedControl.layer.shadowRadius = 5
    }
    
    fileprivate func setupSubmitButton() {
        submitButton.setTitle(model.submitFormTitle, for: UIControl.State())
        submitButton.layer.shadowOffset = CGSize(width: 5, height: 10)
        submitButton.layer.shadowColor = UIColor.white.cgColor
        submitButton.layer.shadowOpacity = 0.1
        submitButton.layer.shadowRadius = 5
    }
    
    fileprivate func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
        
        let attributes: [NSAttributedString.Key: UIColor] = [.foregroundColor: .white]
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email", attributes: attributes)
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password", attributes: attributes)
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: "repeat password", attributes: attributes)
        
        repeatPasswordStackView.isHidden = model.isLoginForm
        updatePasswordReturnKey()
    }
    
    // MARK: Actions
    
    @IBAction fileprivate func actionOnValueChanged(_ sender: UISegmentedControl) {
        model.selectFormOption(for: sender.selectedSegmentIndex)
        submitButton.setTitle(model.submitFormTitle, for: UIControl.State())
        updatePasswordReturnKey()
        clearForm()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.repeatPasswordStackView.isHidden = self.model.isLoginForm
            self.view.layoutIfNeeded()
        })
    }
    
    @IBAction fileprivate func actionOnEditingChanged(_ sender: UITextField) {
        switch sender {
        case emailTextField: model.update(email: emailTextField.text!)
        case passwordTextField: model.update(password: passwordTextField.text!)
        case repeatPasswordTextField: model.update(repeatPassword: repeatPasswordTextField.text!)
        default: print("unexpected sender:\n", sender.debugDescription); break
        }
    }
    
    @IBAction fileprivate func actionOnTouchUpInside(_ sender: UIButton) {
        model.submitForm { user, error in
            if let error = error {
                let title = error.title
                let message = error.localizedDescription
                self.dialog(with: title, and: message)
            } else if let user = user {
                self.delegate.didAuthenticate(user)
            }
        }
    }
    
    // MARK: Convenience
    
    fileprivate func updatePasswordReturnKey() {
        if model.isLoginForm {
            passwordTextField.returnKeyType = .done
        } else if model.isRegistrationForm {
            passwordTextField.returnKeyType = .next
        }
    }
    
    fileprivate func clearForm() {
        let emptyString = ""
        emailTextField.text = emptyString
        model.update(email: emptyString)
        
        passwordTextField.text = emptyString
        model.update(password: emptyString)
        
        repeatPasswordTextField.text = emptyString
        model.update(repeatPassword: emptyString)
    }
}

// MARK: - UITextFieldDelegate -

extension AuthenticationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            if model.isLoginForm {
                passwordTextField.resignFirstResponder()
            } else if model.isRegistrationForm {
                repeatPasswordTextField.becomeFirstResponder()
            }
        } else if textField == repeatPasswordTextField {
            textField.resignFirstResponder()
        }
        return false
    }
}

// MARK: - Dialog -

extension AuthenticationViewController {
    fileprivate func dialog(with title: String, and message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
}

