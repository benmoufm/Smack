//
//  MessageTableViewCell.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 19/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var userImageView: CircleImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var messageBodyLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(message: MessageModel) {
        messageBodyLabel.text = message.messageBody
        userNameLabel.text = message.userName
        userImageView.image = UIImage(named: message.userAvatar)
        userImageView.backgroundColor = UserDataService.instance.returnUIColor(compoments: message.userAvatarColor)
        // TODO : Formatting
        // timeStampLabel.text = message.timeStamp
    }
}
