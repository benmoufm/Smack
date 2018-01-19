//
//  ChatViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!

    // Variables
    var isTyping = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        //sendButton.isHidden = true

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

        SocketService.instance.getMessage { (success) in
            if success {
                self.tableView.reloadData()
                if MessageService.instance.messages.count > 0 {
                    let endIndex = IndexPath(row: MessageService.instance.messages.count - 1, section: 0)
                    self.tableView.scrollToRow(at: endIndex, at: .bottom, animated: false)
                }
            }
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
            tableView.reloadData()
        }
    }

    @objc func channelSelected(_ notification: Notification) {
        updateWithChannel()
    }

    func updateWithChannel() {
        let channelName = MessageService.instance.selectedChannel?.name ?? ""
        channelNameLabel.text = "#\(channelName)"
        getMessages()
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
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func messageBoxEditing(_ sender: Any) {
        if messageTextField.text == "" {
            isTyping = false
            sendButton.isHidden = true
        } else {
            if isTyping == false {
                sendButton.isHidden = false
            }
            isTyping = true
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

    //MARK: - TableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as? MessageTableViewCell {
            let message = MessageService.instance.messages[indexPath.row]
            cell.configureCell(message: message)
            return cell
        }
        return MessageTableViewCell()
    }
}
