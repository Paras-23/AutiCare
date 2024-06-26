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
    func didTapButton(in cell: ProfileInterfaceCollectionViewCell, tag : Int)
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
        let postsRef = Database.database().reference().child("users").child(uid!)
        postsRef.observeSingleEvent(of: .value , with:{ [self] snapshot in
            
            if let value = snapshot.value as? [String: Any], let profileImage = value["profilePicture"] as? String , let fullName = value["fullName"] as? String {
                if let imageURL = URL(string: profileImage) {
                    self.profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
                    profileImageView.maskWhiteCircle(anyImage: profileImageView.image!)
                }
                userName.text = fullName
                
            }
            if let value = snapshot.value as? [String : Any], let cover = value["coverPicture"] as? String {
                if let coverURl = URL(string: cover) {
                    self.coverImageView.sd_setImage(with: coverURl, placeholderImage: UIImage(named: "reload"))
                }
            } else {
                coverImageView.image = UIImage(systemName: "photo")
            }
        })
//        coverImageView.image = UIImage(systemName: "photo")
    }
    
    
    
    
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate?.setSegmentedIndex(index: segmentedControl.selectedSegmentIndex)
    }
    @IBAction func editButtonTapped(_ sender: UIButton) {
        secondDelegate?.didTapButton(in: self, tag : sender.tag)
        
    }
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        secondDelegate?.didTapButton(in: self, tag : sender.tag)
    }
    
    
}
