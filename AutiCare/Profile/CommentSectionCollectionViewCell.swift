//
//  CommentSectionCollectionViewCell.swift
//  AutiCare
//
//  Created by Batch-2 on 06/06/24.
//

import UIKit

class CommentSectionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var commentText: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateCell() {
        profileImage.maskCircle(anyImage: UIImage(named: "Designer-4")!)
        userName.text = "Archie Andrews"
        commentText.text = "Excellent! Keep shining"
    }

}
