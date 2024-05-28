//
//  QuestionTableViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 17/05/24.
//

import UIKit

protocol QuestionTableViewCellDelegate {
    func didSelectButton(cell: QuestionTableViewCell , answer : Int)
}
class QuestionTableViewCell: UITableViewCell {
    
    @IBOutlet var questionLabel: UILabel!
    var answer : Int = 0
    var delegate : QuestionTableViewCellDelegate?
    
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
        for button in buttonsPressed {
            button.backgroundColor = defaultBackgroundConfiguration().backgroundColor
        }
        delegate?.didSelectButton(cell: self, answer: sender.tag)
        sender.backgroundColor = .systemMint
        
    }
    
}
