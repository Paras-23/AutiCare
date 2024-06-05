//
//  ProfileTabMainViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit

extension UIImageView {
    
    public func maskCircle(anyImage: UIImage) {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.width/2.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}

class ProfileTabMainViewController: UIViewController, currentSegment {
    
    var selectedSegment : Int = -1
    
    func setSegmentedIndex(index: Int) {
        selectedSegment = index
    }
    
    
    @IBOutlet var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let firstSectionCell = UINib(nibName: "ProfileInterface", bundle: nil)
        collectionView.register(firstSectionCell, forCellWithReuseIdentifier: "ProfileHeader")
        
        let secondSectionCell = UINib(nibName: "PostSegmentCollectionViewCell", bundle: nil)
        collectionView.register(secondSectionCell, forCellWithReuseIdentifier: "PostSegmentCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Do any additional setup after loading the view.
    }
    
}

extension ProfileTabMainViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileInterfaceCollectionViewCell
            cell.updateCellConfiguration()
            cell.delegate = self
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostSegmentCell", for: indexPath) as! PostSegmentCollectionViewCell
            cell.updatePostImage()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileInterfaceCollectionViewCell
            cell.updateCellConfiguration()
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 15
        default: return 1
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                section = self.firstSectionLayout()
            case 1:
                section = self.postSegmentLayout()
            default:
                section = self.firstSectionLayout()
            }
            return section
        }
        return layout
    }
    
    func firstSectionLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.53))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }

    func postSegmentLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.335), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 2)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.20))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
