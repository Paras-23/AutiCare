//
//  MemoryCardViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 27/05/24.
//

import UIKit

class MemoryCardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var gameOverLabel: UILabel!
    @IBOutlet var monkeyImage: UIImageView!
    
    let fruitImages = [UIImage(named: "apple"), UIImage(named: "orange"), UIImage(named: "grapes"),
                       UIImage(named: "watermelon"), UIImage(named: "strawberry"), UIImage(named: "cherry"),
                       UIImage(named: "apple"), UIImage(named: "orange"), UIImage(named: "grapes"),
                       UIImage(named: "watermelon"), UIImage(named: "strawberry"), UIImage(named: "cherry")]

    var shuffledFruits = [UIImage?]()
    var firstSelectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        gameOverLabel.isHidden = true
        monkeyImage.isHidden = true
        
        collectionView.dataSource = self
        collectionView.delegate = self

        shuffledFruits = fruitImages.shuffled()
        collectionView.isEditing = false
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        collectionView.isScrollEnabled = false
    }

     func generateLayout() -> UICollectionViewLayout {
         let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.333), heightDimension: .fractionalHeight(1.0))
         let item = NSCollectionLayoutItem(layoutSize: itemSize)
         item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
         let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.245))
         let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
         let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func isGameOver() -> Bool{
        for row in 0...11 {
            let cell = collectionView.cellForItem(at: [0, row]) as! CardCollectionViewCell
            if cell.imageView.isHidden == true {
                return false
            }
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}

extension MemoryCardViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shuffledFruits.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FruitCell", for: indexPath) as! CardCollectionViewCell
        cell.imageView.isHidden = true
        cell.imageView.image = shuffledFruits[indexPath.item]
        cell.backgroundColor = .white
//        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 15
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            if cell.imageView.isHidden == false {
                return
            }
            cell.imageView.isHidden = false
        }

        if let firstIndexPath = firstSelectedIndexPath {
            if firstIndexPath != indexPath {
                if shuffledFruits[firstIndexPath.item] == shuffledFruits[indexPath.item] {
                    // Matched
                    if self.isGameOver() == true {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            self.gameOverLabel.isHidden = false
                            self.monkeyImage.isHidden = false
                            self.gameOverLabel.text = "YOU WON"
                            collectionView.layer.opacity = 50
                        }
                    }
                } else {
                    // Not matched
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        if let firstCell = collectionView.cellForItem(at: firstIndexPath) as? CardCollectionViewCell {
                            firstCell.imageView.isHidden = true
                        }
                        if let secondCell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
                            secondCell.imageView.isHidden = true
                        }
                    }
                }
                firstSelectedIndexPath = nil
            }
        } else {
            firstSelectedIndexPath = indexPath
        }
    }
}
