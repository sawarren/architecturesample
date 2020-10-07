//
//  HomeViewController.swift
//  architecturesample
//
//  Created by Steven Warren on 11/08/2018.
//  Copyright © 2018 conduit. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: class {
    func viewControllerDidLogOut(_ viewController: HomeViewController)
}

class HomeViewController: UIViewController {
    
    // MARK: - Variables -

    @IBOutlet weak var profilePhotoImageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var memberSinceLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    var model: HomeViewModel!
    weak var delegate: HomeViewControllerDelegate!
    
    // MARK: - Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private API -
    // MARK: Setup
    
    fileprivate func setupView() {
        emailLabel.text = model.emailAddress
        memberSinceLabel.text = model.registrationDateString
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoImageView.bounds.height/2
        if let photoData = model.profilePhotoData {
            profilePhotoImageView.image = UIImage(data: photoData)
        }
    }
    
    // MARK: Actions
    
    @IBAction fileprivate func actionOnTouchUpInside(_ sender: UIButton) {
        delegate.viewControllerDidLogOut(self)
    }
}
