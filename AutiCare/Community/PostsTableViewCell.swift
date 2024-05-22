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
   

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

   
    
    func configure(with model: AuticarePosts){
        
        self.usernameLabel.text = model.username
        self.userImageView.image = UIImage(named: model.UserImageName)
        self.postImageView.image = UIImage(named: model.postImageName)
        
    }
    
}

