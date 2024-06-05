//
//  PostSegmentCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit

class PostSegmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updatePostImage() {
        imageView.image = UIImage(named: "DummyPost3")
    }

}
