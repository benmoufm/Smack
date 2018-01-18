//
//  ChannelViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class ChannelViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var userImageView: CircleImageView!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {}
    @IBOutlet weak var channelTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChannelViewController.userDataDidChange(_:)),
                                               name: NOTIF_USER_DATA_DID_CHANGE,
                                               object: nil)
    }

    override func viewDidAppear(_ animated: Bool) {
        setupUserInfo()
    }

    @IBAction func addChannelButtonPressed(_ sender: Any) {
        let addChannel = AddChannelViewController()
        addChannel.modalPresentationStyle = .custom
        present(addChannel, animated: true, completion: nil)
    }

    func setupUserInfo() {
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

    @IBAction func loginButtonPressend(_ sender: Any) {
        if AuthentificationService.instance.isLoggedIn {
            let profile = ProfileViewController()
            profile.modalPresentationStyle = .custom
            present(profile, animated: true, completion: nil)
        } else {
            performSegue(withIdentifier: TO_LOGIN, sender: nil)
        }
    }

    @objc func userDataDidChange(_ notification: Notification) {
        setupUserInfo()
    }

    // MARK: - Table view delegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.channels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "channelCell", for: indexPath) as? ChannelTableViewCell {
            let channel = MessageService.instance.channels[indexPath.row]
            cell.configureCell(channel: channel)
            return cell
        }
        return ChannelTableViewCell()
    }
}
