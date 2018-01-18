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

    func clearChannel() {
        channels.removeAll()
    }
}
