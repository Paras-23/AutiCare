//
//  ChatSectionTableViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit

class ChatSectionTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImageView.maskCircle(anyImage: UIImage(named: "David Beckham")!)
        userName.text = "David Beckham"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        

        // Configure the view for the selected state
    }
    
}
