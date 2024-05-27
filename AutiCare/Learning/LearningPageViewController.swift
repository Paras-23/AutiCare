//
//  FirstLearningPageViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 27/05/24.
//

import UIKit

class LearningPageViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Learning"
        self.tabBarItem.image = UIImage(systemName: "brain")
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: performSegue(withIdentifier: "memoryCardSegue", sender: nil)
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
        case 1: print("Cell called \(indexPath.row)")
        default: return
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return DataModel.games.count
        case 1:
            return DataModel.sessions.count
        case 2:
            return DataModel.worksheets.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0 :
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Games", for: indexPath) as! GamesCollectionViewCell
            cell.updateGames(with: DataModel.games[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.systemMint.cgColor
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Sessions", for: indexPath) as! SessionsCollectionViewCell
            cell.updateSessions(with: DataModel.sessions[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.systemMint.cgColor
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Worksheets", for: indexPath) as! WorksheetsCollectionViewCell
            cell.updateWorksheets(with: DataModel.worksheets[indexPath.item])
            cell.layer.cornerRadius = 35
            cell.layer.borderWidth = 2.5
            cell.layer.borderColor = UIColor.systemMint.cgColor
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Games", for: indexPath) as! GamesCollectionViewCell
            cell.updateGames(with: DataModel.games[indexPath.item])
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
                headerView.headerLabel.text = DataModel.sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                
                headerView.button.tag = indexPath.section
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
                
            case 1:
                headerView.headerLabel.text = DataModel.sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.button.setTitle("See All", for: .normal)
            case 2:
                headerView.headerLabel.text = DataModel.sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                headerView.button.setTitle("See All", for: .normal)
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
    
    
   @objc func headerButtonTapped(_ sender:UIButton){
        let storyboard = UIStoryboard(name: "Learning", bundle: nil)
       let viewController = storyboard.instantiateViewController(withIdentifier: "SectionViewController") as! SectionViewController
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @IBAction func unwindToLearningPageViewController(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }
}
