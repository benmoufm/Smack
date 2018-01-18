//
//  ChannelTableViewCell.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 18/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class ChannelTableViewCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var channelNameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            layer.backgroundColor = UIColor(white: 1, alpha: 0.2).cgColor
        } else {
            layer.backgroundColor = UIColor.clear.cgColor
        }
    }

    func configureCell(channel: ChannelModel) {
        let title = channel.name ?? ""
        channelNameLabel.text = "#\(title)"
    }
}
