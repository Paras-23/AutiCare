//
//  HeaderSectionCollectionViewCell.swift
//  AutiCare
//
//  Created by Abcom on 06/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

protocol presentSegment{
    func presentSegment(index : Int)
}

class HeaderSectionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var addRemoveFriendRequest: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var infoButton: UIButton!
    
    var buttonState : Bool = false
    var userId = String()
    
    
    var delegate2 : presentSegment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPopUpButton()
        // Initialization code
    }
    
    func setupPopUpButton() {
        let blockClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let reportClosure = { (action: UIAction) in
            print(action)
        }
                
        infoButton.menu = UIMenu(children: [
            UIAction(title: "Block Account", handler: blockClosure),
            UIAction(title: "Report Account", handler: reportClosure)
        ])
        infoButton.showsMenuAsPrimaryAction = true
    }
    
    func updateCellConfiguration(userId : String) {
        let postsRef = Database.database().reference().child("users").child(userId)
        postsRef.observeSingleEvent(of: .value , with:{ [self] snapshot in
            
            if let value = snapshot.value as? [String: Any], let profileImage = value["profilePicture"] as? String , let username = value["fullName"] as? String {
                if let imageURL = URL(string: profileImage) {
                    self.profileImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
                    profileImageView.maskWhiteCircle(anyImage: profileImageView.image!)
                }
                userName.text = username
            }
        })
        coverImageView.image = UIImage(named: "DummyPost8")
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate2?.presentSegment(index: segmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        let uid = Auth.auth().currentUser?.uid
        let userPostsRef = Database.database().reference().child("users").child(uid!).child("following").child(userId)
        userPostsRef.setValue(true) { error, _ in
            if let error = error {
                print("Failed to update user posts: \(error.localizedDescription)")
                return
            }
        }
        sender.titleLabel?.text = "following"
    }
    @IBAction func reportButtonTapped(_ sender: UIButton) {
    }
}
