//
//  AvatarPickerViewController.swift
//  Smack
//
//  Created by Mélodie Benmouffek on 17/01/2018.
//  Copyright © 2018 Mélodie Benmouffek. All rights reserved.
//

import UIKit

class AvatarPickerViewController: UIViewController, UICollectionViewDelegate,
    UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    // Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCollectionViewCell {
            return cell
        }
        return AvatarCollectionViewCell()
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    @IBAction func segmantedControlChanged(_ sender: Any) {
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
