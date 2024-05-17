//
//  QuestionTableViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 17/05/24.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    
    @IBOutlet var questionLabel: UILabel!
    
    
    @IBOutlet var buttonsPressed: [UIButton]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func buttonsPressed(_ sender: UIButton) {
        buttonsPressed[0].backgroundColor = defaultBackgroundConfiguration().backgroundColor
        buttonsPressed[1].backgroundColor = defaultBackgroundConfiguration().backgroundColor
        buttonsPressed[2].backgroundColor = defaultBackgroundConfiguration().backgroundColor
        buttonsPressed[3].backgroundColor = defaultBackgroundConfiguration().backgroundColor
        buttonsPressed[4].backgroundColor = defaultBackgroundConfiguration().backgroundColor
        
        switch sender {
        case buttonsPressed[0] : buttonsPressed[0].backgroundColor = .systemBlue
        case buttonsPressed[1] : buttonsPressed[1].backgroundColor = .systemBlue
        case buttonsPressed[2] : buttonsPressed[2].backgroundColor = .systemBlue
        case buttonsPressed[3] : buttonsPressed[3].backgroundColor = .systemBlue
        case buttonsPressed[4] : buttonsPressed[4].backgroundColor = .systemBlue
        default :
            break
        }
    }
    
}
