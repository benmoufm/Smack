//
//  Constants.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 15/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()

// URL Constants
let BASE_URL = "https://chattychatchatfurax.herokuapp.com/v1/"
let URL_REGISTER = "\(BASE_URL)account/register/"
let URL_LOGIN = "\(BASE_URL)account/login/"
let URL_USER_ADD = "\(BASE_URL)user/add/"
let URL_USER_BY_EMAIL = "\(BASE_URL)user/byEmail/"
let URL_GET_CHANNEL = "\(BASE_URL)channel/"

// Colors
let smackPurplePlaceHolder = #colorLiteral(red: 0.3254901961, green: 0.4196078431, blue: 0.7764705882, alpha: 0.5)

// Notification Constants
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

// Segues
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

// User Defaults
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

// Headers
let HEADER = ["ContentType": "application/json; charset=utf-8"]
let BEARER_HEADER = [
    "Authorization": "Bearer \(AuthentificationService.instance.authentificationToken)",
    "ContentType": "application/json; charset=utf-8"
]
