//
//  TableViewCell.swift
//  AutiCare
//
//  Created by Sudhanshu Singh Rajput on 05/06/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    
 
    @IBOutlet weak var categoryImageView: UIImageView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    func updateGamesConfig(game:Games){
        categoryImageView.image = UIImage(named: game.imageName)
        categoryLabel.text = game.gameName
    }
    func updateWorksheetsConfig(workSheet : Worksheet){
        categoryLabel.text = workSheet.worksheetName
        categoryImageView.image = UIImage(named: workSheet.titleImage)
        
    }
    func updateSessionsConfig(session:Sessions){
        categoryLabel.text = session.sessionName
        categoryImageView.image = UIImage(named: session.imageName)
    }

}
