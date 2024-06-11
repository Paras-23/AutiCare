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
        
        let newCommentCell = UINib(nibName: "AddNewCommentCollectionViewCell", bundle: nil)
        collectionView.register(newCommentCell, forCellWithReuseIdentifier: "NewComment")
        
        collectionView.delegate = self
        collectionView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension CommentSectionViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0...3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCell", for: indexPath) as! CommentSectionCollectionViewCell
            cell.updateCell()
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewComment", for: indexPath) as! AddNewCommentCollectionViewCell
            return cell
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 5
        
    }
}
