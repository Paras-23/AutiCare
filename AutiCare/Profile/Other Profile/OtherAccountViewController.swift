//
//  OtherAccountViewController.swift
//  AutiCare
//
//  Created by Abcom on 06/06/24.
//

import UIKit

class OtherAccountViewController: UIViewController , presentSegment{
    
    var selectedSegment : Int = 0
    
    func presentSegment(index: Int) {
        selectedSegment = index
        collectionView.reloadData()
    }
    
    
    @IBOutlet var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let firstSectionCell = UINib(nibName: "HeaderSectionCollectionViewCell", bundle: nil)
        collectionView.register(firstSectionCell, forCellWithReuseIdentifier: "HeaderCell")
        
        let secondSectionCell = UINib(nibName: "PostSegmentCollectionViewCell", bundle: nil)
        collectionView.register(secondSectionCell, forCellWithReuseIdentifier: "PostSegmentCell")
        
        let thirdSectionCell = UINib(nibName: "AboutSectionCollectionViewCell", bundle: nil)
        collectionView.register(thirdSectionCell, forCellWithReuseIdentifier: "AboutSection")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)

        // Do any additional setup after loading the view.
    }
    
}

extension OtherAccountViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! HeaderSectionCollectionViewCell
            cell.updateCellConfiguration()
            cell.delegate2 = self
            return cell
        case 1:
            switch selectedSegment {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostSegmentCell", for: indexPath) as! PostSegmentCollectionViewCell
                cell.updateUserImage()
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AboutSection", for: indexPath) as! AboutSectionCollectionViewCell
                cell.updateAbout()
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeaderCell", for: indexPath) as! ProfileInterfaceCollectionViewCell
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
        case 1: return 10
        default: return 1
        }
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            switch sectionIndex {
            case 0:
                section = self.firstSectionLayout()
            case 1:
                switch self.selectedSegment {
                case 0:
                    section = self.postSegmentLayout()
                default:
                    section = self.aboutSegmentLayout()
                }
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.47))
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
    
    func aboutSegmentLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 7, bottom: 0, trailing: 7)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.085))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 0, bottom: 1, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
