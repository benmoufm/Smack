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

    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        guard let name = usernameTextField.text, usernameTextField.text != "" else { return }
        guard let email = emailTextField.text, emailTextField.text != "" else { return }
        guard let password = passwordTextField.text, passwordTextField.text != "" else { return }

        AuthentificationService.instance.registerUser(email: email, password: password) { (success) in
            if success {
                AuthentificationService.instance.loginUser(email: email, password: password, completion: { (success) in
                    AuthentificationService.instance.addUser(name: name,
                                                             email: email,
                                                             avatarName: self.avatarName,
                                                             avatarColor: self.avatarColor,
                                                             completion: { (success) in
                                                                if success {
                                                                    print(UserDataService.instance.name,
                                                                          UserDataService.instance.avatarName)
                                                                    self.performSegue(withIdentifier: UNWIND, sender: nil)
                                                                }
                    })
                })
            }
        }
    }

    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }

    @IBAction func pickBackgroundColorPressed(_ sender: Any) {
    }
    

}
