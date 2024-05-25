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
        models.append(AuticarePosts( numberOfLikes: 200, username: "Madhav Verma", userImageName: "head", postImageName: "post_1", postCaption: "mkvnrdknvjd fjvnj jknj d dnfjvndfjivnburidbvjdnvj fjknvjrdnkv djkfnvjkd vkjdnjbndkmf vkmdfnjkvdlfm vdfnbdjnksdlmvnsjknafjgewfbskmd cjshevfhnjkfv sd njrnvjbsjk vkrj ggjr vjsbvhbdrjv jdrbguhgerbjfk d"))
        models.append(AuticarePosts(numberOfLikes: 120, username: "Paras singhal", userImageName: "head", postImageName: "post_2", postCaption: "nfjesnjcvngsdnfjvd hbvfjskd vhjsbcjksd mvdfiv"))
        models.append(AuticarePosts(numberOfLikes: 687, username: "Sudhanshu kumar", userImageName: "head", postImageName: "post_3", postCaption: "nsejknvjkernjkfnvjdkfv jr dvjk rjv jke vkrnjinverm vmknerjkv emvokwenkfkw rvkmer bke kjbneklrggknjksnkgndsjknvmlsnjkfnksndjkfsan cknfoekmvklsnojvnsklvmsknvkrelkvnjkdsnvlkgrdnvkjnrsklvmlsknksnklbd kld"))
        
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
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.8))
        
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
