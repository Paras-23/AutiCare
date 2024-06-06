//
//  FirstLearningPageViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit
import AVKit

class LearningPageViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Learning"
        self.tabBarItem.image = UIImage(systemName: "brain")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 0){
            switch indexPath.row {
            case 0: performSegue(withIdentifier: "memoryCardSegue", sender: nil)
                self.tabBarController?.tabBar.isHidden = true
            case 1: performSegue(withIdentifier: "pictureRepresentingActionGameSegue", sender: nil)
                self.tabBarController?.tabBar.isHidden = true
            case 2: performSegue(withIdentifier: "SaveTheDotSegue", sender: nil)
                self.tabBarController?.tabBar.isHidden = true
                
            default: return
            }
        }
        if indexPath.section == 1{
            switch indexPath.row{
            case 0:
                let url = Bundle.main.url(forResource: "playingWithFriends", withExtension: "mp4")
                let avPlayer = AVPlayer(url: url!)
                let avController = AVPlayerViewController()
                avController.player = avPlayer
                present(avController,animated: true){
                    avPlayer.play()
                }
                
            default:
                break
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return games.count
        case 1:
            return sessions.count
        case 2:
            return worksheets.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Games", for: indexPath) as! GamesCollectionViewCell
            cell.updateGames(with: games[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
            return cell
            
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sessions", for: indexPath) as! SessionsCollectionViewCell
            cell.updateSessions(with: sessions[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Worksheets", for: indexPath) as! WorksheetsCollectionViewCell
            cell.updateWorksheets(with: worksheets[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Games", for: indexPath) as! GamesCollectionViewCell
            cell.updateGames(with: games[indexPath.item])
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.black.cgColor
            return cell
        }
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gamesNib = UINib(nibName: "Games", bundle: nil)
        collectionView.register(gamesNib, forCellWithReuseIdentifier: "Games")
        
        let sessionsNib = UINib(nibName: "Sessions", bundle: nil)
        collectionView.register(sessionsNib, forCellWithReuseIdentifier: "Sessions")
        
        let worksheetsNib = UINib(nibName: "Worksheets", bundle: nil)
        collectionView.register(worksheetsNib, forCellWithReuseIdentifier: "Worksheets")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            
            switch indexPath.section{
            case 0:
                headerView.headerLabel.text = sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                
                headerView.button.tag = indexPath.section
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.tintColor = UIColor(.init(red: 0.001, green: 0.301, blue: 0.500))
                headerView.button.addTarget(self, action: #selector(gamesHeaderButtonTapped(_:)), for: .touchUpInside)
                
            case 1:
                headerView.headerLabel.text = sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.button.tintColor = UIColor(.init(red: 0.001, green: 0.301, blue: 0.500))
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(sessionsHeaderButtonTapped(_:)), for: .touchUpInside)
            case 2:
                headerView.headerLabel.text = sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.button.tintColor = UIColor(.init(red: 0.001, green: 0.301, blue: 0.500))
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(worksheetsHeaderButtonTapped(_:)), for: .touchUpInside)
            default:
                headerView.headerLabel.text = "Default Header"
            }
            return headerView
        }
        fatalError("Unexpected element kind")
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection
            
            switch sectionIndex {
            case 0:
                section = self.generateGames()
            case 1:
                section = self.generateSessions()
            case 2:
                section = self.generateWorksheets()
            default:
                section = self.generateGames()
            }
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment:  .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }
    func generateGames() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    func generateSessions() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    func generateWorksheets() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(300))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(8.0)
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 8)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    
    
   @objc func gamesHeaderButtonTapped(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Learning", bundle: nil)
       let viewController = storyboard.instantiateViewController(withIdentifier: "GamesTableViewController") as! GamesTableViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    @objc func sessionsHeaderButtonTapped(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Learning", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"SessionsTableViewController" ) as! SessionsTableViewController
            navigationController?.pushViewController(viewController, animated: true)
    }
    @objc func worksheetsHeaderButtonTapped(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Learning", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"WorkSheetsTableViewController" ) as! WorkSheetsTableViewController
            navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func unwindToLearningPageViewController(_ unwindSegue: UIStoryboardSegue) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
