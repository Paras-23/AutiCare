//
//  FriendsTableViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    
    @IBOutlet var profilePictureImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateInfo(with user : User) {
        profilePictureImageView.maskCircle(anyImage: UIImage(named: user.profilePicture!)!)
        userName.text = user.fullName
    }

}
