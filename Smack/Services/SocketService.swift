//
//  SocketService.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 18/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit
import SocketIO

class SocketService: NSObject {
    static let instance = SocketService()

    override init() {
        super.init()
    }

    let manager = SocketManager(socketURL: URL(string: BASE_URL)!, config: [.log(true), .compress])

    func establishConnection() {
        manager.defaultSocket.connect()
    }

    func closeConnection() {
        manager.defaultSocket.disconnect()
    }

    func addChannel(channelName: String, channelDescription: String, completion: @escaping CompletionHandler) {
        manager.defaultSocket.emit("newChannel", channelName, channelDescription)
        completion(true)
    }

    func getChannel(completion: @escaping CompletionHandler) {
        manager.defaultSocket.on("channelCreated") { (dataArray, ack) in
            guard let channelName = dataArray[0] as? String else { return }
            guard let channelDescription = dataArray[1] as? String else { return }
            guard let channelId = dataArray[2] as? String else { return }

            let newChannel = ChannelModel(_id: channelId, name: channelName, description: channelDescription, __v: nil)
            MessageService.instance.channels.append(newChannel)
            completion(true)
        }
    }

    func addMessage(messageBody: String, userId: String, channelId: String, completion: @escaping CompletionHandler) {
        let user = UserDataService.instance
        manager.defaultSocket.emit("newMessage", messageBody, userId, channelId, user.name, user.avatarName, user.avatarColor)
        completion(true)
    }

    func getMessage(completion: @escaping CompletionHandler) {
        manager.defaultSocket.on("messageCreated") { (dataArray, ack) in
            guard let messageBody = dataArray[0] as? String,
                let channelId = dataArray[2] as? String,
                let userName = dataArray[3] as? String,
                let userAvatar = dataArray[4] as? String,
                let userAvatarColor = dataArray[5] as? String,
                let messageId = dataArray[6] as? String,
                let timeStamp = dataArray[7] as? String else { return }

            if channelId == MessageService.instance.selectedChannel?._id
                && AuthentificationService.instance.isLoggedIn {
                let message = MessageModel(messageBody: messageBody,
                                           userName: userName,
                                           channelId: channelId,
                                           userAvatar: userAvatar,
                                           userAvatarColor: userAvatarColor,
                                           id: messageId,
                                           timeStamp: timeStamp)
                MessageService.instance.messages.append(message)
                completion(true)
            } else {
                completion(false)
            }
        }
    }

    func getTypingUsers(_ completionHandler: @escaping (_ typingUsers: [String: String]) -> Void) {
        manager.defaultSocket.on("userTypingUpdate") { (dataArray, ack) in
            guard let typingUsers = dataArray[0] as? [String: String] else { return }
            completionHandler(typingUsers)
        }
    }
}
