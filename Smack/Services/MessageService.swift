//
//  MessageService.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 18/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MessageService {
    static let instance = MessageService()

    var messages = [MessageModel]()
    var channels = [ChannelModel]()
    var selectedChannel: ChannelModel?
    let sessionManager = SessionManagerService.instance.sessionManager

    func findAllChannels(completion: @escaping CompletionHandler) {
        sessionManager.request(URL_GET_CHANNEL,
                               method: .get,
                               parameters: nil,
                               encoding: JSONEncoding.default,
                               headers: BEARER_HEADER)
            .responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    do {
                        self.channels = try JSONDecoder().decode([ChannelModel].self, from: data)
                        completion(true)
                    } catch let error {
                        completion(false)
                        debugPrint(error as Any)
                    }
                    NotificationCenter.default.post(name: NOTIF_CHANNELS_LOADED, object: nil)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }

    func findAllMessagesForChannel(channelId: String, completion: @escaping CompletionHandler) {
        sessionManager.request("\(URL_GET_MESSAGES)\(channelId)",
                               method: .get,
                               parameters: nil,
                               encoding: JSONEncoding.default,
                               headers: BEARER_HEADER)
            .responseJSON { (response) in
                if response.result.error == nil {
                    self.clearMessages()
                    guard let data = response.data else { return }
                    do {
                        if let json = try JSON(data: data).array {
                            for item in json {
                                let messageBody = item["messageBody"].stringValue
                                let channelId = item["channelId"].stringValue
                                let id = item["_id"].stringValue
                                let userName = item["userName"].stringValue
                                let userAvatar = item["userAvatar"].stringValue
                                let userAvatarColor = item["userAvatarColor"].stringValue
                                let timeStamp = item["timeStamp"].stringValue

                                let message = MessageModel(messageBody: messageBody,
                                                           userName: userName,
                                                           channelId: channelId,
                                                           userAvatar: userAvatar,
                                                           userAvatarColor: userAvatarColor,
                                                           id: id,
                                                           timeStamp: timeStamp)
                                self.messages.append(message)
                            }
                            completion(true)
                        }
                    } catch let error {
                        debugPrint(error as Any)
                        completion(false)
                    }
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }














    func clearMessages() {
        messages.removeAll()
    }

    func clearChannel() {
        channels.removeAll()
    }
}
