//
//  ChannelViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController {

    // Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImageView: CircleImageView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChannelViewController.userDataDidChange(_:)),
                                               name: NOTIF_USER_DATA_DID_CHANGE,
                                               object: nil)
    }

    @IBAction func loginButtonPressend(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }

    @objc func userDataDidChange(_ notification: Notification) {
        if AuthentificationService.instance.isLoggedIn {
            loginButton.setTitle(UserDataService.instance.name, for: .normal)
            userImageView.image = UIImage(named: UserDataService.instance.avatarName)
            userImageView.backgroundColor = UserDataService.instance.returnUIColor(compoments: UserDataService.instance.avatarColor)
        } else {
            loginButton.setTitle("Login", for: .normal)
            userImageView.image = UIImage(named: "menuProfileIcon")
            userImageView.backgroundColor = UIColor.clear
        }
    }
}
