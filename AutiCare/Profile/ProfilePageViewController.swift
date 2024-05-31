//
//  ProfilePageViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 28/05/24.
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

class ProfilePageViewController: UIViewController,UICollectionViewDataSource {
    
    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 4
        case 1:
            return 2
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePageSection2", for: indexPath) as! ProfilePageSection2CollectionViewCell
            cell.layer.backgroundColor = UIColor.systemMint.cgColor
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfilePageSection1", for: indexPath) as! ProfilePageSection1CollectionViewCell
            return cell
        }
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let profilePageSection1 = UINib(nibName: "ProfilePageSection1", bundle: nil)
        collectionView.register(profilePageSection1, forCellWithReuseIdentifier: "ProfilePageSection1")
        let profilePageSection2 = UINib(nibName: "ProfilePageSection2", bundle: nil)
        collectionView.register(profilePageSection2, forCellWithReuseIdentifier: "ProfilePageSection2")
        collectionView.dataSource = self
    
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
    }
    
    func generateLayout()->UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, env)->NSCollectionLayoutSection? in switch section{
        case 0:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1) , heightDimension: .absolute(90))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
            group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 15, trailing: 8)
            let section = NSCollectionLayoutSection(group: group)
            return section
        case 1:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 5, trailing:8)
            let groupSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1) , heightDimension: .absolute(250))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count:  2)
            group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 0, trailing: 8)
            var section = NSCollectionLayoutSection(group: group)
            return section
    
        case 1:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 5, trailing: 8)
            let groupSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1) , heightDimension: .absolute(60))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem:  item, count: 1)
//            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
            group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom:0 , trailing: 8)
            let section = NSCollectionLayoutSection(group: group)
            return section
        default:
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension:.fractionalWidth(1) , heightDimension: .absolute(70))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
            group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            let section = NSCollectionLayoutSection(group: group)
            return section
            
            }
        }
        return layout
    }


}
