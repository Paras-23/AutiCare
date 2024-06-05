//
//  ProfileInterfaceCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit

protocol currentSegment {
    func setSegmentedIndex(index : Int)
}

class ProfileInterfaceCollectionViewCell: UICollectionViewCell {
    
    var delegate : currentSegment?
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    func updateCellConfiguration() {
        coverImageView.image = UIImage(named: "DummyPost10")
        profileImageView.maskCircle(anyImage: UIImage(named: "DummyPost6")!)
        userName.text = "Sudhanshu Singh Rajput"
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate?.setSegmentedIndex(index: segmentedControl.selectedSegmentIndex)
    }
}
