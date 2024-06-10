//
//  ProfileInterfaceCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol currentSegment {
    func setSegmentedIndex(index : Int)
}

protocol CollectionCellDelegate {
    func didTapButton(in cell: ProfileInterfaceCollectionViewCell)
}

class ProfileInterfaceCollectionViewCell: UICollectionViewCell {
    
    var delegate : currentSegment?
    var secondDelegate : CollectionCellDelegate?
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    func updateCellConfiguration() {
        let uid = Auth.auth().currentUser?.uid
        let postsRef = Database.database().reference().child("user").child(uid!)
        postsRef.observeSingleEvent(of: .value , with:{ [self] snapshot in
            
            if let value = snapshot.value as? [String: Any], let profileImage = value["profilePicture"] as? String , let username = value["userName"] as? String {
                if let imageURL = URL(string: profileImage) {
                    self.profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
                    profileImageView.maskWhiteCircle(anyImage: profileImageView.image!)
                }
                userName.text = username
            }
        })
        coverImageView.image = UIImage(named: "DummyPost10")
    }
    
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate?.setSegmentedIndex(index: segmentedControl.selectedSegmentIndex)
    }
    @IBAction func editButtonTapped(_ sender: UIButton) {
        secondDelegate?.didTapButton(in: self)
        
    }
    
    
}
