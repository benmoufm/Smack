//
//  AuthentificationService.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 16/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AuthentificationService {
    static let instance = AuthentificationService()

    let sessionManager = SessionManagerService.instance.sessionManager
    let defaults = UserDefaults.standard
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    var authentificationToken: String {
        get {
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    var userEmail: String {
        get {
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }

    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        sessionManager.request(URL_REGISTER,
                          method: .post,
                          parameters: body,
                          encoding: JSONEncoding.default,
                          headers: HEADER)
            .responseString() {
                (response) in
                if response.result.error == nil {
                    completion(true)
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }

    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        sessionManager.request(URL_LOGIN,
                               method: .post,
                               parameters: body,
                               encoding: JSONEncoding.default,
                               headers: HEADER)
            .responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    do {
                        let json = try JSON(data: data)
                        self.userEmail = json["user"].stringValue
                        self.authentificationToken = json["token"].stringValue
                        completion(true)
                    } catch {
                        completion(false)
                        debugPrint("Error JSON parsing")
                    }
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }

    func addUser(name: String, email: String, avatarName: String,
                 avatarColor: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        let body: [String: Any] = [
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
        ]
        let header = [
            "Authorization": "Bearer \(AuthentificationService.instance.authentificationToken)",
            "ContentType": "application/json; charset=utf-8"
        ]
        sessionManager.request(URL_USER_ADD,
                               method: .post,
                               parameters: body,
                               encoding: JSONEncoding.default,
                               headers: header)
            .responseJSON { (response) in
                if response.result.error == nil {
                    guard let data = response.data else { return }
                    do {
                        let json = try JSON(data: data)
                        let id = json["_id"].stringValue
                        let avatarColor = json["avatarColor"].stringValue
                        let avatarName = json["avatarName"].stringValue
                        let email = json["email"].stringValue
                        let name = json["name"].stringValue
                        UserDataService.instance.setUserData(id: id,
                                                             avatarColor: avatarColor,
                                                             avatarName: avatarName,
                                                             email: email,
                                                             name: name)
                        self.isLoggedIn = true
                        completion(true)
                    } catch {
                        completion(false)
                        debugPrint("Error JSON parsing")
                    }
                } else {
                    completion(false)
                    debugPrint(response.result.error as Any)
                }
        }
    }
}
