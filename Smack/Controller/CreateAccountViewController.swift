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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // Variables
    var avatarName = "profileDefault"
    var avatarColor = "[0.5, 0.5, 0.5, 1]"
    var backgroundColor: UIColor?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            if avatarName.contains("light") && backgroundColor == nil {
                userImageView.backgroundColor = UIColor.lightGray
            }
        }
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: UNWIND, sender: nil)
    }

    @IBAction func createAccountPressed(_ sender: Any) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
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
                                                                    self.activityIndicator.isHidden = true
                                                                    self.activityIndicator.stopAnimating()
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
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255

        backgroundColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        UIView.animate(withDuration: 0.2) {
            self.userImageView.backgroundColor = self.backgroundColor
        }
    }

    func setupView() {
        activityIndicator.isHidden = true
        usernameTextField.attributedPlaceholder = NSAttributedString(string: "username",
                                                                     attributes: [
                                                                        NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder
            ])
        emailTextField.attributedPlaceholder = NSAttributedString(string: "email",
                                                                     attributes: [
                                                                        NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder
            ])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "password",
                                                                     attributes: [
                                                                        NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder
            ])
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountViewController.handleTap))
        view.addGestureRecognizer(tap)
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

}
