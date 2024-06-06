//
//  SessionsTableViewController.swift
//  AutiCare
//
//  Created by Sudhanshu Singh Rajput on 05/06/24.
//

import UIKit
import AVKit

class SessionsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "LearningTableViewCell")
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sessions.count
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearningTableViewCell", for: indexPath) as! TableViewCell
        cell.updateSessionsConfig(session: sessions[indexPath.row])
   
        return cell
    }
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:  let url = Bundle.main.url(forResource: "playingWithFriends", withExtension: "mp4")
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
