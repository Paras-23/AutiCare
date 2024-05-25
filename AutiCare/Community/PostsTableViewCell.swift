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
       
    }

   
    
    func configure(with model: AuticarePosts){
        
        self.usernameLabel.text = model.username
        userImageView.maskCircle(anyImage: UIImage(named: model.userImageName)!)
        self.postImageView.image = UIImage(named: model.postImageName)
        self.captionLabel.text = model.postCaption
    }
    
    @IBOutlet var options: UICommand!
    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
    }
}

