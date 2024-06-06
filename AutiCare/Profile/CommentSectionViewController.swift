//
//  CommentSectionViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 06/06/24.
//

import UIKit

class CommentSectionViewController: UIViewController {
    

    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstCell = UINib(nibName: "CommentSectionCollectionViewCell", bundle: nil)
        collectionView.register(firstCell, forCellWithReuseIdentifier: "CommentCell")
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
}

extension CommentSectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentSectionCollectionViewCell
        cell.updateCell()
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
}
