//
//  ChatAccountsTableViewCell.swift
//  AutiCare
//
//  Created by Abcom on 05/06/24.
//

import UIKit

class ChatAccountsTableViewCell: UITableViewCell {

    @IBOutlet var chatProfileImage: UIImageView!
    @IBOutlet var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        chatProfileImage.maskCircle(anyImage: UIImage(named: "DummyPost10")!)
        userNameLabel.text = "Lionel Andres Messi"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
