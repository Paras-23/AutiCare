//
//  GamesCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var gameTitle: UILabel!
    
    
    func updateGames(with games:Games){
        imageView.image = UIImage(named: games.imageName)
        imageView.layer.borderWidth = 1
    }
}
