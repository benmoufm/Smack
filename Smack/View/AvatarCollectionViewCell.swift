//
//  AvatarCollectionViewCell.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class AvatarCollectionViewCell: UICollectionViewCell {

    // Outlets
    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func setUpView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
