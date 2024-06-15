//
//  AboutSectionCollectionViewCell.swift
//  AutiCare
//
//  Created by Abcom on 06/06/24.
//

import UIKit

class AboutSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var infoLabel : UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateAbout(row : Int) {
        switch row {
        case 0:
            titleLabel.text = "Name"
            infoLabel.text = "Tommy Vercetti"
        case 1:
            titleLabel.text = "Age"
            infoLabel.text = "30"
        case 2:
            titleLabel.text = "Bio"
            infoLabel.text = "A parent and a therapist"
        case 3:
            titleLabel.text = "Location"
            infoLabel.text = "New Delhi"
        case 4:
            titleLabel.text = "Email"
            infoLabel.text = "tommy@gmail.com"
        default:
            titleLabel.text = "Title"
            infoLabel.text = "Information"
        }
    }

}
