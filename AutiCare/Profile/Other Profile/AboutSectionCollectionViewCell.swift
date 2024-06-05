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
        // Initialization code
    }
    
    func updateAbout() {
        titleLabel.text = "Name"
        infoLabel.text = "Paras Singhal"
    }

}
