//
//  AddChannelViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 18/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class AddChannelViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createChannelButtonPressed(_ sender: Any) {

    }

    func setupView() {
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(AddChannelViewController.closeTap(_:)))
        backgroundView.addGestureRecognizer(closeTouch)

        nameTextField.attributedPlaceholder = NSAttributedString(string: "name", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "description", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceHolder])
    }

    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
}
