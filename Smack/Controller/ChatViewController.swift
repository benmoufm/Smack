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
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.bindToKeyboard()
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChatViewController.handleTap))
        view.addGestureRecognizer(tap)

        menuButton.addTarget(self.revealViewController(),
                             action: #selector(SWRevealViewController.revealToggle(_:)),
                             for: .touchUpInside)
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChatViewController.userDataDidChange(_:)),
                                               name: NOTIF_USER_DATA_DID_CHANGE,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ChatViewController.channelSelected(_:)),
                                               name: NOTIF_CHANNEL_SELECTED,
                                               object: nil)

        if AuthentificationService.instance.isLoggedIn {
            AuthentificationService.instance.findUserByEmail(completion: { (success) in
                if success {
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                }
            })
        }
    }

    @objc func handleTap() {
        view.endEditing(true)
    }

    @objc func userDataDidChange(_ notification: Notification) {
        if AuthentificationService.instance.isLoggedIn {
            onLoginGetMessages()
        } else {
            channelNameLabel.text = "Please Log In"
        }
    }

    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
    }

    func onLoginGetMessages() {
        MessageService.instance.findAllChannels { (success) in
            if success {
                if MessageService.instance.channels.count > 0 {
                    MessageService.instance.selectedChannel = MessageService.instance.channels[0]
                    self.updateWithChannel()
                } else {
                    self.channelNameLabel.text = "No channels yet !"
                }
            }
        }
    }

    func getMessages() {
        guard let channelId = MessageService.instance.selectedChannel?._id else { return }
        MessageService.instance.findAllMessagesForChannel(channelId: channelId) { (success) in
            if success {

            }
        }
    }

    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        if AuthentificationService.instance.isLoggedIn {
            guard let channelId = MessageService.instance.selectedChannel?._id else { return }
            guard let message = messageTextField.text else { return }

            SocketService.instance.addMessage(messageBody: message,
                                              userId: UserDataService.instance.id,
                                              channelId: channelId,
                                              completion: { (success) in
                if success {
                    self.messageTextField.text = ""
                    self.messageTextField.resignFirstResponder()
                }
            })
        }
    }
}
