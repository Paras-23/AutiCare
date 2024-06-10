//
//  EditProfileTableViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit

class EditProfileTableViewController: UITableViewController {
    

    @IBOutlet var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section{
        case 0: return 1
        case 1: return 1
        case 2: return 5
        case 3: return 3
        default: return 0
        }
    }
}
