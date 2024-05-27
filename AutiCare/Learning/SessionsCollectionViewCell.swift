//
//  SessionsCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit

class SessionsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func updateSessions(with sessions:Sessions){
        imageView.image = UIImage(named: sessions.imageName)
    }
}
