//
//  UserDataService.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import Foundation

class UserDataService {
    static let instance = UserDataService()

    private(set) var id = ""
    private(set) var avatarColor = ""
    private(set) var avatarName = ""
    private(set) var email = ""
    private(set) var name = ""

    func setUserData(id: String, avatarColor: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = avatarColor
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }

    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }

    func returnUIColor(compoments: String) -> UIColor {
        let scanner = Scanner(string: compoments)
        let skipped = CharacterSet(charactersIn: "[], ")
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped

        var r, g, b, a: NSString?
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)

        let defaultColor = UIColor.lightGray

        guard let rUnwrapped = r,
            let gUnwrapped = g,
            let bUnwrapped = b,
            let aUnwrapped = a else { return defaultColor }

        let rFloat = CGFloat(rUnwrapped.doubleValue)
        let gFloat = CGFloat(gUnwrapped.doubleValue)
        let bFloat = CGFloat(bUnwrapped.doubleValue)
        let aFloat = CGFloat(aUnwrapped.doubleValue)

        let color = UIColor(red: rFloat, green: gFloat, blue: bFloat, alpha: aFloat)

        return color
    }

    func logoutUser() {
        id = ""
        name = ""
        email = ""
        avatarName = ""
        avatarColor = ""

        AuthentificationService.instance.isLoggedIn = false
        AuthentificationService.instance.userEmail = ""
        AuthentificationService.instance.authentificationToken = ""
        MessageService.instance.clearChannel()
    }
}
