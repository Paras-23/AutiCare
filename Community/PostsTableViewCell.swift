//
//  PostsTableViewCell.swift
//  AutiCare
//
//  Created by sourav_singh on 20/05/24.
//

import UIKit
import SafariServices
import SDWebImage

class PostsTableViewCell: UICollectionViewCell, UINavigationControllerDelegate {

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
    
    func showPost(with post : Post){
        usernameLabel.text = post.userName
        userImageView.maskCircle(anyImage: UIImage(named: post.userImageName!)!)
        captionLabel.text = post.caption
        if let imageURL = URL(string: post.imageURL) {
            postImageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
                }
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
    
   
    @IBAction func likeButton(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func commentButton(_ sender: UIButton) {
        
    }
    
    
    @IBAction func shareButton(_ sender: UIButton) {
        guard let image = postImageView.image else {return}
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender
    }
    
}

