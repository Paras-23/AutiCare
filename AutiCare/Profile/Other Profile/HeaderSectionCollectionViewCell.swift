//
//  HeaderSectionCollectionViewCell.swift
//  AutiCare
//
//  Created by Abcom on 06/06/24.
//

import UIKit

protocol presentSegment{
    func presentSegment(index : Int)
}

class HeaderSectionCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var addRemoveFriendRequest: UIButton!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var messageButton: UIButton!
    @IBOutlet var infoButton: UIButton!
    
    var buttonState : Bool = false
    
    
    
    var delegate2 : presentSegment?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupPopUpButton()
        // Initialization code
    }
    
    func setupPopUpButton() {
        let blockClosure = { (action: UIAction) in
            print(action.title)
        }
        
        let reportClosure = { (action: UIAction) in
            print(action)
        }
                
        infoButton.menu = UIMenu(children: [
            UIAction(title: "Block Account", handler: blockClosure),
            UIAction(title: "Report Account", handler: reportClosure)
        ])
        infoButton.showsMenuAsPrimaryAction = true
    }
    
    
    func updateCellConfiguration() {
        coverImageView.image = UIImage(named: "DummyPost8")
        profileImageView.maskCircle(anyImage: UIImage(named: "DummyPost4")!)
        userName.text = "Sudhanshu Singh Rajput"
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        delegate2?.presentSegment(index: segmentedControl.selectedSegmentIndex)
    }
    
    @IBAction func followButtonTapped(_ sender: UIButton) {
        
    }
    @IBAction func reportButtonTapped(_ sender: UIButton) {
    }
}
