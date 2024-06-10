//
//  CommunityPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 22/05/24.
//

import UIKit
import FirebaseDatabaseInternal
import FirebaseAuth

class CommunityPageViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, commentsTapped {
    
    func didTapComments(in cell: PostsTableViewCell) {
        if let indexPath = feedCollectionView.indexPath(for: cell) {
            performSegue(withIdentifier: "SegueToComments", sender: indexPath)
        }
    }
    
    
    @IBOutlet var feedCollectionView: UICollectionView!
    @IBOutlet var exploreCollectionView: UICollectionView!
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var searchBarStack: UIStackView!
    
    @IBOutlet var categoryButton: UIButton!
    
    var firstNib : UINib = UINib()
    
    var posts : [Post] = []
    var allOrCategoryWisePosts : [Post] = []
    let feedRefreshControl = UIRefreshControl()
    let exploreRefreshControl = UIRefreshControl()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case feedCollectionView: return posts.count
        case exploreCollectionView : return allOrCategoryWisePosts.count
        default: return 0
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        switch collectionView {
        case feedCollectionView: return 1
        case exploreCollectionView : return 1
        default: return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case feedCollectionView:
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "UserPost", for: indexPath) as! PostsTableViewCell
            cell.showPost(with: posts[indexPath.row])
            cell.delegate = self
            return cell
            
        case exploreCollectionView:
            let cell = exploreCollectionView.dequeueReusableCell(withReuseIdentifier: "UserExplore", for: indexPath) as! ExplorePostsCollectionViewCell
            
            cell.showPosts(post: allOrCategoryWisePosts[indexPath.row])
            return cell
            
        default:
            let cell = feedCollectionView.dequeueReusableCell(withReuseIdentifier: "UserPost", for: indexPath) as! PostsTableViewCell
            cell.showPost(with: posts[indexPath.row])
            return cell
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryButton.showsMenuAsPrimaryAction = true
        categoryButton.menu = buttonMenu()
        
        exploreCollectionView.isHidden = true
        searchBar.backgroundImage = UIImage()
        searchBarStack.isHidden = true

        selectingCollectionView()
        
        feedRefreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        feedCollectionView.refreshControl = feedRefreshControl
        
        exploreRefreshControl.addTarget(self, action: #selector(refreshAllOrCategoryWisePosts), for: .valueChanged)
        exploreCollectionView.refreshControl = exploreRefreshControl
        
        fetchPosts()
        fetchAllPosts()

    }
    
    func buttonMenu() -> UIMenu {
        
        
        let allAction = UIAction(title: "All", image: nil) { (_) in
            self.fetchAllPosts()
        }
        let eduAction = UIAction(title: "Education", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Education")
        }
        let sportsAction = UIAction(title: "Sports", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Sports")
        }
        let healthAction = UIAction(title: "Health", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Health")
        }
        let achievementsAction = UIAction(title: "Achievements", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Achievements")
        }
        let motivationAction = UIAction(title: "Motivation", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Motivation")
        }
        let creativityAction = UIAction(title: "Creativity", image: nil) { (_) in
            self.fetchCategoryWisePosts(category: "Creativity")
        }

        return UIMenu(title: "", options: .displayInline, children: [allAction, eduAction, sportsAction, healthAction, achievementsAction, motivationAction, creativityAction])
    }
    
    @objc func refreshPosts() {
        fetchPosts()
    }

    func fetchPosts() {
//        if let uid = Auth.auth().currentUser?.uid {
//            CommunityDataController.shared.fetchOnlinePosts(forUserID: uid) { [weak self] posts in
//                guard let self = self else { return }
//                self.posts = posts
//                self.feedCollectionView.reloadData()
//                self.refreshControl.endRefreshing()
//            }
//        } else {
        posts = CommunityDataController.shared.getPosts()
            feedCollectionView.reloadData()
            feedRefreshControl.endRefreshing()
//        }
    }
    
    @objc func refreshAllOrCategoryWisePosts() {
        var category = (categoryButton.menu?.selectedElements)![0].title
        if category == "All" {
            fetchAllPosts()
        }
        else {
            fetchCategoryWisePosts(category: category)
        }
        exploreRefreshControl.endRefreshing()
    }

    func fetchAllPosts() {
        PostService.fetchAllPosts(){ posts in
            self.allOrCategoryWisePosts = posts
            self.exploreCollectionView.reloadData()
        }
    }
    
    func fetchCategoryWisePosts(category : String) {
        PostService.fetchCategoryWisePosts(category: category){ posts in
            self.allOrCategoryWisePosts = posts
            self.exploreCollectionView.reloadData()
        }
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
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2.5, bottom: 0, trailing: 2.5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        group.contentInsets = NSDirectionalEdgeInsets(top: 2.5, leading: 0, bottom: 2.5, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        return UICollectionViewCompositionalLayout(section: section)
    }
        
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            print("Feed Tab")
            feedCollectionView.isHidden = false
            exploreCollectionView.isHidden = true
            searchBarStack.isHidden = true
            selectingCollectionView()
            
        } else if sender.selectedSegmentIndex == 1{
            print("Explore Page")
            feedCollectionView.isHidden = true
            exploreCollectionView.isHidden = false
            searchBarStack.isHidden = false
            selectingCollectionView()
        }
    }
    
    @IBAction func unwindToCommunityPageViewController(_ unwindSegue: UIStoryboardSegue) {
        // Use data from the view controller which initiated the unwind segue
    }
    

}

