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
        guard let date = message.timeStamp else { return }
        let end = date.index(date.endIndex, offsetBy: -5)
        let isoDate = date.substring(to: end)
        let isoFormatter = ISO8601DateFormatter()
        let messageDate = isoFormatter.date(from: isoDate.appending("Z"))

        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMM d, h:mm a"
        if let finalDate = messageDate {
            let finalDateString = newFormatter.string(from: finalDate)
            timeStampLabel.text = finalDateString
        }
    }
}
