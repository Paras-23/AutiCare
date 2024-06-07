//
//  ExplorePostsCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-1 on 07/06/24.
//

import UIKit
import SDWebImage

class ExplorePostsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!
    
    func showPosts(post : Post){
        if let imageURL = URL(string: post.imageURL) {
            imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload"))
        }
    }
    
}
