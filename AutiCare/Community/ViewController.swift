//
//  ViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet var table : UITableView!

        
    var models = [AuticarePosts]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            table.register(PostsTableViewCell.nib(), forCellReuseIdentifier: PostsTableViewCell.identifier)
            
            table.delegate = self
            table.dataSource = self
            
            models.append(AuticarePosts( numebrOfLikes: 200, username: "Madhav Verma", UserImageName: "head", postImageName: "post_1"))
            models.append(AuticarePosts(numebrOfLikes: 120, username: "Paras singhal", UserImageName: "head", postImageName: "post_2"))
            models.append(AuticarePosts(numebrOfLikes: 687, username: "Sudhanshu kumar", UserImageName: "head", postImageName: "post_3"))
            
        }
    
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return models.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: PostsTableViewCell.identifier, for: indexPath) as! PostsTableViewCell
            cell.configure(with: models[indexPath.row])
            
            return cell
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
        }
        
    }
    
    struct AuticarePosts {
        let numebrOfLikes: Int
        let username: String
        let UserImageName: String
        let postImageName: String
    }
    

