//
//  FriendsCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit

class FriendsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func updateInformation() {
        profileImageView.maskCircle(anyImage: UIImage(named: "DummyPost9")!)
        userName.text = "Tommy Vercetti"
    }
}

