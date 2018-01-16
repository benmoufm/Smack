//
//  CreateAccountViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    // Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var userImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        guard let email = emailTextField.text, emailTextField.text != "" else {
            return
        }
        guard let password = passwordTextField.text, passwordTextField.text != "" else {
            return
        }

        AuthentificationService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                print("Registered user")
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
    }

    @IBAction func pickBackgroundColorPressed(_ sender: Any) {
    }
    

}
