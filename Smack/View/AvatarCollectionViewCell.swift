//
//  AvatarCollectionViewCell.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

enum AvartarType {
    case dark
    case light

    var description: String {
        switch self {
        case .dark:
            return "dark"
        case .light:
            return "light"
        }
    }

    var color: CGColor {
        switch self {
        case .dark:
            return UIColor.lightGray.cgColor
        case .light:
            return UIColor.gray.cgColor
        }
    }
}

class AvatarCollectionViewCell: UICollectionViewCell {

    // Outlets
    @IBOutlet weak var avatarImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }

    func configureCell(index: Int, avatarType: AvartarType) {
        avatarImageView.image = UIImage(named: "\(avatarType.description)\(index)")
        layer.backgroundColor = avatarType.color
    }

    func setUpView() {
        layer.backgroundColor = UIColor.lightGray.cgColor
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
