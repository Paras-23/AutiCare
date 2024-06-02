//
//  CommunityPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit

class CommunityPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var feedCollectionView: UICollectionView!
    @IBOutlet var groupsCollectionView: UICollectionView!
    @IBOutlet var exploreCollectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    var firstNib : UINib = UINib()
    
    var posts : [Post] = []

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case feedCollectionView: return 3
        case groupsCollectionView : return 0
        case exploreCollectionView : return 9
        default: return 0
        }
//        3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case feedCollectionView: return 1
        case groupsCollectionView : return 1
        case exploreCollectionView : return 1
        default: return 0
        }
//        1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case feedCollectionView:
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "UserPost", for: indexPath) as! PostsTableViewCell
            cell.showPost(with: posts[indexPath.row])
            return cell
            
        case groupsCollectionView:
            let cell = groupsCollectionView.dequeueReusableCell(withReuseIdentifier: "UserGroups", for: indexPath)
            return cell
            
        case exploreCollectionView:
            let cell = exploreCollectionView.dequeueReusableCell(withReuseIdentifier: "UserExplore", for: indexPath)
            return cell
            
            
        default:
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "UserPost", for: indexPath) as! PostsTableViewCell
            cell.showPost(with: posts[indexPath.row])
            return cell
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupsCollectionView.isHidden = true
        exploreCollectionView.isHidden = true
        self.searchBar.backgroundImage = UIImage()
        
        selectingCollectionView()
        
        if let onlinePosts = CommunityDataController.shared.onlinePosts() {
            posts = onlinePosts
        }
        else {
            posts = CommunityDataController.shared.getPosts()
        }

        // Do any additional setup after loading the view.
    }
    
    func selectingCollectionView() {
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            print("Entering case 0")
            feedCollectionView.dataSource = self
            feedCollectionView.delegate = self
            firstNib = UINib(nibName: "PostsTableViewCell", bundle: nil)
            feedCollectionView.register(firstNib, forCellWithReuseIdentifier: "UserPost")
            feedCollectionView.setCollectionViewLayout(generateFeedLayout(), animated: true)
        case 1:
            print("Entering case 1")
            groupsCollectionView.dataSource = self
            groupsCollectionView.delegate = self
            firstNib = UINib(nibName: "GroupcCollectionViewCell", bundle: nil)
            groupsCollectionView.register(firstNib, forCellWithReuseIdentifier: "UserGroups")
        case 2:
            print("Entering case 2")
            exploreCollectionView.dataSource = self
            exploreCollectionView.delegate = self
            firstNib = UINib(nibName: "ExploreCollectionViewCell", bundle: nil)
            exploreCollectionView.register(firstNib, forCellWithReuseIdentifier: "UserExplore")
            exploreCollectionView.setCollectionViewLayout(generateExploreLayout(), animated: true)
        default:
            feedCollectionView.dataSource = self
            feedCollectionView.delegate = self
            firstNib = UINib(nibName: "PostsTableViewCell", bundle: nil)
            feedCollectionView.register(firstNib, forCellWithReuseIdentifier: "UserPost")
            feedCollectionView.setCollectionViewLayout(generateFeedLayout(), animated: true)
        }
    }
    
    func generateFeedLayout() -> UICollectionViewLayout {
        //Create the item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.75))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count : 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 10, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func generateExploreLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.32), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.32))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
        
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            print("Feed Tab")
            feedCollectionView.isHidden = false
            exploreCollectionView.isHidden = true
            groupsCollectionView.isHidden = true
            searchBar.isHidden = true
            selectingCollectionView()
            
        } else if (sender.selectedSegmentIndex == 1) {
            print("Group Tabs")
            feedCollectionView.isHidden = true
            exploreCollectionView.isHidden = true
            groupsCollectionView.isHidden = false
            searchBar.isHidden = false
            selectingCollectionView()
            
        } else {
            print("Explore Page")
            feedCollectionView.isHidden = true
            exploreCollectionView.isHidden = false
            groupsCollectionView.isHidden = true
            searchBar.isHidden = false
            selectingCollectionView()
        }
    }
    
    
    
    
    
    
    
    @IBAction func unwindToCommunityPageViewController(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
    }

}

