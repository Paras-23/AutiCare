//
//  ProfileTabMainViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 05/06/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
    
    public func maskWhiteCircle(anyImage: UIImage) {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.width/2.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}

class ProfileTabMainViewController: UIViewController, currentSegment {
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle.fill")
    }
    
    var selectedSegment : Int = 0
    
    var posts : [Post] = []
    let refreshControl = UIRefreshControl()
    
    func setSegmentedIndex(index: Int) {
        selectedSegment = index
        collectionView.reloadData()
    }
    
    
    @IBOutlet var collectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let firstSectionCell = UINib(nibName: "ProfileInterface", bundle: nil)
        collectionView.register(firstSectionCell, forCellWithReuseIdentifier: "ProfileHeader")
        
        let secondSectionCell = UINib(nibName: "PostSegmentCollectionViewCell", bundle: nil)
        collectionView.register(secondSectionCell, forCellWithReuseIdentifier: "PostSegmentCell")
        
        let thirdSectionCell = UINib(nibName: "FriendsCollectionViewCell", bundle: nil)
        collectionView.register(thirdSectionCell, forCellWithReuseIdentifier: "AccountCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        refreshControl.addTarget(self, action: #selector(refreshPosts), for: .valueChanged)
        collectionView.refreshControl = refreshControl
        
        fetchPosts()

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshPosts() {
            fetchPosts()
        }

    func fetchPosts() {
        if let uid = Auth.auth().currentUser?.uid {
            PostService.fetchCurrentUserPosts(forUserID: uid) { posts in
                self.posts = posts
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
    
    @IBAction func unwindToProfileTabMainViewController(_ unwindSegue: UIStoryboardSegue) {
        
    }
    
}

extension ProfileTabMainViewController : UICollectionViewDataSource, UICollectionViewDelegate, CollectionCellDelegate {
    
    func didTapButton(in cell: ProfileInterfaceCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            performSegue(withIdentifier: "editProfileSegue", sender: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileInterfaceCollectionViewCell
            cell.updateCellConfiguration()
            cell.delegate = self
            cell.secondDelegate = self
            return cell
        case 1:
            switch selectedSegment {
            case 0:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostSegmentCell", for: indexPath) as! PostSegmentCollectionViewCell
                cell.updatePostImage(post: posts[indexPath.row])
                return cell
            default:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccountCell", for: indexPath) as! FriendsCollectionViewCell
                cell.updateInformation()
                return cell
            }
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileHeader", for: indexPath) as! ProfileInterfaceCollectionViewCell
            cell.updateCellConfiguration()
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.section {
        case 1:
            switch selectedSegment {
            case 0:
                print("HAHA")
            case 1...2:
                performSegue(withIdentifier: "VisitOtherProfile", sender: nil)
            default:
                print("Nothing")
            }
        default:
            print("OK")
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return posts.count
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
                    section = self.followsSegmentLayout()
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
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.58))
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
    
    func followsSegmentLayout() -> NSCollectionLayoutSection {
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
