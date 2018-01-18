//
//  LoginViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        activityIndicator.isHidden = true
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                     attributes: [
                                                                        NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder
            ])
        userPasswordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [
                                                                        NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder
            ])
    }

    @IBAction func loginButtonPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()

        guard let email = userNameTextField.text, userNameTextField.text != "" else { return }
        guard let password = userPasswordTextField.text, userPasswordTextField.text != "" else { return }
        AuthentificationService.instance.loginUser(email: email, password: password) { (success) in
            if success {
                AuthentificationService.instance.findUserByEmail(completion: { (success) in
                    if success {
                        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                        self.activityIndicator.isHidden = true
                        self.activityIndicator.stopAnimating()
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            }
        }
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createAccountButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
}
