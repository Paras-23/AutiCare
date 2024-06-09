//
//  SeeAllTableViewController.swift
//  AutiCare
//
//  Created by Abcom on 09/06/24.
//

import UIKit
import AVKit

class SeeAllTableViewController: UITableViewController {
    
    var contentToShow : ContentType?
    var selectedWorksheetIndex : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableCell = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(tableCell, forCellReuseIdentifier: "LearningTableViewCell")

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
        switch contentToShow {
        case .game:
            return games.count
        case .session:
            return sessions.count
        case .worksheet:
            return worksheets.count
        case nil:
            return games.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LearningTableViewCell", for: indexPath) as! TableViewCell
        
        switch contentToShow {
        case .game:
            cell.updateGamesConfig(game: games[indexPath.row])
            return cell
        case .session:
            cell.updateSessionsConfig(session: sessions[indexPath.row])
            return cell
        case .worksheet:
            cell.updateWorksheetsConfig(workSheet: worksheets[indexPath.row])
        case nil:
            return cell
        }

        return cell
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Learning", bundle: nil)
        switch contentToShow {
        case .game:
            let nextVC = storyboard.instantiateViewController(withIdentifier: games[indexPath.row].storyboardID!)
            navigationController?.pushViewController(nextVC, animated: true)
        case .session:
            let url = Bundle.main.url(forResource: sessions[indexPath.row].resourceURL, withExtension: "mp4")
            let avPlayer = AVPlayer(url: url!)
            let avController = AVPlayerViewController()
            avController.player = avPlayer
            present(avController,animated: true){
                avPlayer.play()
            }
        case .worksheet:
            selectedWorksheetIndex = indexPath.row
            performSegue(withIdentifier: "WorkSheetsView", sender: nil)
        case nil:
            print()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WorkSheetsView" {
            if let destinationVC = segue.destination as? WorkSheetsViewController, let selectedIndex = selectedWorksheetIndex {
                destinationVC.selectedWorksheet = worksheets[selectedIndex]
            }
        }
    }


}
