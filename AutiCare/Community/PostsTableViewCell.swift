//
//  PostsTableViewCell.swift
//  AutiCare
//
//  Created by sourav_singh on 20/05/24.
//

import UIKit

class PostsTableViewCell: UICollectionViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var captionLabel: UILabel!
    @IBOutlet var infoButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        postImageView.layer.borderWidth = 0.5
        setupPopUpButton()
       
    }
    
    func configure(with model: AuticarePosts){
        
        self.usernameLabel.text = model.username
        userImageView.maskCircle(anyImage: UIImage(named: model.userImageName)!)
        self.postImageView.image = UIImage(named: model.postImageName)
        self.captionLabel.text = model.postCaption
    }
    
    func setupPopUpButton() {
        let blockClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let unfollowClosure = { (action: UIAction) in
            print(action)
        }
        
        let reportClosure = { (action: UIAction) in
            print(action)
        }
                
        infoButton.menu = UIMenu(children: [
            UIAction(title: "Block Account", handler: blockClosure),
            UIAction(title: "Unfollow Account", handler: unfollowClosure),
            UIAction(title: "Report Post", handler: reportClosure)
        ])
        infoButton.showsMenuAsPrimaryAction = true
    }
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {

    }
    
   
    
}

