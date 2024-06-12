//
//  PostSegmentCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit
import SDWebImage

class PostSegmentCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updatePostImage(post : Post) {
        if let imageURL = URL(string: post.imageURL) {
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
                }
    }

}
