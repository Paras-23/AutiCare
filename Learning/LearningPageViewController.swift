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
    
    var selectedWorksheetIndex : Int?
    var selectedSeeAllButton : ContentType?
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 0){
            let nextVC = storyboard!.instantiateViewController(withIdentifier: games[indexPath.row].storyboardID!)
            navigationController?.pushViewController(nextVC, animated: true)
        }
        if indexPath.section == 1{
                let url = Bundle.main.url(forResource: sessions[indexPath.row].resourceURL, withExtension: "mp4")
                let avPlayer = AVPlayer(url: url!)
                let avController = AVPlayerViewController()
                avController.player = avPlayer
                present(avController,animated: true){
                    avPlayer.play()
                }
        }
        
        if indexPath.section == 2{
            selectedWorksheetIndex = indexPath.row
            performSegue(withIdentifier: "WorkbookController", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkbookController" {
            if let destinationVC = segue.destination as? WorkSheetsViewController, let worksheetIndex = selectedWorksheetIndex {
                destinationVC.selectedWorksheet = worksheets[worksheetIndex]
            }
        }
        
        if segue.identifier == "SeeAllSegue" {
            if let destinationVC = segue.destination as? SeeAllTableViewController, let content = selectedSeeAllButton {
                destinationVC.contentToShow = content
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section{
        case 0 :
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LearningIcons", for: indexPath) as! LearningSections
        cell.layer.cornerRadius = 35
        cell.layer.borderWidth = 2.5
        cell.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
        switch indexPath.section{
        case 0 :
            cell.updateGames(with: games[indexPath.item])
            return cell
        case 1:
            cell.updateSessions(with: sessions[indexPath.item])
            return cell
        case 2:
            cell.updateWorksheets(with: worksheets[indexPath.item])
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LearningIcons", for: indexPath) as! LearningSections
            return cell
        }
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gamesNib = UINib(nibName: "LearningSections", bundle: nil)
        collectionView.register(gamesNib, forCellWithReuseIdentifier: "LearningIcons")
        
        collectionView.setCollectionViewLayout(generateLayout(), animated: true)
        
        collectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
                
                headerView.headerLabel.text = sectionHeader[indexPath.section]
                headerView.headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
                
                headerView.button.tag = indexPath.section
                headerView.button.setTitle("See All", for: .normal)
                headerView.button.tintColor = UIColor(red: 0.001, green: 0.301, blue: 0.500, alpha: 1.0)
                headerView.button.addTarget(self, action: #selector(seeAllHeaderButtonTapped(_:)), for: .touchUpInside)
                
                return headerView
            }
            fatalError("Unexpected element kind")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 44)
    }
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, env)->NSCollectionLayoutSection? in let section: NSCollectionLayoutSection

            section = self.generateSectionLayout()
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment:  .top)
            section.boundarySupplementaryItems = [header]
            return section
        }
        return layout
    }
    func generateSectionLayout() -> NSCollectionLayoutSection {
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
    
    @objc func seeAllHeaderButtonTapped(_ sender:UIButton){
        switch sender.tag {
            case 0:
                selectedSeeAllButton = .game
            case 1:
                selectedSeeAllButton = .session
            case 2:
                selectedSeeAllButton = .worksheet
            default:
                selectedSeeAllButton = nil
            }
            performSegue(withIdentifier: "SeeAllSegue", sender: nil)
    }
    
    @IBAction func unwindToLearningPageViewController(_ unwindSegue: UIStoryboardSegue) {
        self.tabBarController?.tabBar.isHidden = false
    }
}
