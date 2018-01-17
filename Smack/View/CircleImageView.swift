//
//  CircleImageView.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

@IBDesignable
class CircleImageView: UIImageView {

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    func setupView() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setupView()
    }

}
