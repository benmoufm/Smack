//
//  RoundedButton.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 16/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        self.setupView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.setupView()
    }

    func setupView() {
        self.layer.cornerRadius = cornerRadius
    }

}
