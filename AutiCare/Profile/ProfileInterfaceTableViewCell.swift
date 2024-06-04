//
//  ProfileInterfaceTableViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 04/06/24.
//

import UIKit

class ProfileInterfaceTableViewCell: UITableViewCell {
    
    @IBOutlet var coverImage: UIImageView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userName.text = "Anna WIlliams"
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
