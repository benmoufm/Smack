//
//  ChatViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        menuButton.addTarget(self.revealViewController(),
                             action: #selector(SWRevealViewController.revealToggle(_:)),
                             for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        if AuthentificationService.instance.isLoggedIn {
            AuthentificationService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
        MessageService.instance.findAllChannels { (success) in
            if success {
                
            }
        }
    }

}
