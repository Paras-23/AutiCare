//
//  GamesCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit

class LearningSections: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
   
    @IBOutlet weak var titleLabel: UILabel!
    
    func updateGames(with games:Games){
        imageView.image = UIImage(named: games.imageName)
        imageView.layer.borderWidth = 1
        titleLabel.text = games.gameName
    }
    
    func updateSessions(with sessions:Sessions){
        imageView.image = UIImage(named: sessions.imageName)
        imageView.layer.borderWidth = 1
        titleLabel.text = sessions.sessionName
    }
    
    func updateWorksheets(with worksheets:Worksheet){
        imageView.image = UIImage(named: worksheets.titleImage)
        imageView.layer.borderWidth = 1
        titleLabel.text = worksheets.worksheetName
}
}
