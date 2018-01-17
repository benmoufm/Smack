//
//  SessionManagerService.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation
import Alamofire

class SessionManagerService {
    static let instance = SessionManagerService()

    var sessionManager: SessionManager

    init() {
        let configuration = URLSessionConfiguration.default
        configuration.urlCredentialStorage = nil
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}
