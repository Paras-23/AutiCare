//
//  HeaderSectionCollectionViewCell.swift
//  AutiCare
//
//  Created by Abcom on 06/06/24.
//

import UIKit

protocol presentSegment{
    func presentSegment(index : Int)
}

class HeaderSectionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var addRemoveFriendRequest: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    var delegate2 : presentSegment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func updateCellConfiguration() {
        coverImageView.image = UIImage(named: "DummyPost8")
        profileImageView.maskCircle(anyImage: UIImage(named: "DummyPost4")!)
        userName.text = "Sudhanshu Singh Rajput"
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate2?.presentSegment(index: segmentedControl.selectedSegmentIndex)
    }
}
