//
//  PostsTableViewCell.swift
//  AutiCare
//
//  Created by sourav_singh on 20/05/24.
//

import UIKit

class PostsTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var usernameLabel: UILabel!
   

    static let identifier = "PostsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "PostsTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: AuticarePosts){
        
        self.usernameLabel.text = model.username
        self.userImageView.image = UIImage(named: model.UserImageName)
        self.postImageView.image = UIImage(named: model.postImageName)
        
    }
    
}

