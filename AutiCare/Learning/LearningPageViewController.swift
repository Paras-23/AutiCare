//
//  LearningPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class LearningPageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        18
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        if let imageView = cell.contentView.viewWithTag(100) as? UIImageView {
            imageView.image = UIImage(named: "Designer-\(indexPath.row + 1).png")
            imageView.layer.borderWidth = 2
             
        }

        return cell
    }
    
    
    func generateLayout() -> UICollectionViewLayout {
        //Create the item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32), heightDimension: .fractionalHeight(0.9))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count : 3)
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
         
    }
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Learning"
        self.tabBarItem.image = UIImage(systemName: "brain.head.profile")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
