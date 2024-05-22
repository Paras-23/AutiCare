//
//  ProfileInfoViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 22/05/24.
//

import UIKit

class ProfileInfoViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: parentProfile.count
        case 1: childProfile.count
        default: parentProfile.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = profileTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        switch indexPath.section {
        case 0: content.text = parentProfile[indexPath.row]
        case 1: content.text = childProfile[indexPath.row]
        default:
            content.text = ""
        }
        cell.contentConfiguration = content
        return cell
        
        }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Parent"
        case 1: return "Child"
        default: return "Empty"
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0:return 36
        default:return 0
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at:indexPath , animated: true)
    }
    
    @IBOutlet var profileTableView: UITableView!
    
    
    var parentProfile :[String] = ["Name","Username","E-Mail","Gender"]
    var childProfile :[String] = ["Name","Date OF Birth","Gender"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
    }
    


}
