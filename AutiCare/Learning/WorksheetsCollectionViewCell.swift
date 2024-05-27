//
//  WorksheetsCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit

class WorksheetsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    
    func updateWorksheets(with worksheets:Worksheets){
        imageView.image = UIImage(named: worksheets.imageName)
    }
    
}
