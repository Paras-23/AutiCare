//
//  CommunityPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class CommunityPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    var models = [AuticarePosts]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserPosts", for: indexPath) as! PostsTableViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        models.append(AuticarePosts( numebrOfLikes: 200, username: "Madhav Verma", UserImageName: "head", postImageName: "post_1"))
                    models.append(AuticarePosts(numebrOfLikes: 120, username: "Paras singhal", UserImageName: "head", postImageName: "post_2"))
                    models.append(AuticarePosts(numebrOfLikes: 687, username: "Sudhanshu kumar", UserImageName: "head", postImageName: "post_3"))
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        let firstNib = UINib(nibName: "PostsTableViewCell", bundle: nil)
        collectionView.register(firstNib, forCellWithReuseIdentifier: "UserPosts")

        // Do any additional setup after loading the view.
    }
    
    func generateLayout() -> UICollectionViewLayout {
        //Create the item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count : 1)
        
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
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
