//
//  ProfilePageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 01/06/24.
//

import UIKit

extension UIImageView {
    
    public func maskCircle(anyImage: UIImage) {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1).cgColor
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.width/2.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}

class ProfilePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var userCoverPhoto: UIImageView!
    @IBOutlet var userProfilePhoto: UIImageView!
    @IBOutlet var userFullName: UILabel!
    @IBOutlet var segmentedControl: UISegmentedControl!
    
    
    
    var currentUsers = CommunityDataController.shared.getUsers()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentUsers[0].following.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserInfo", for: indexPath) as! FriendsTableViewCell
        cell.updateInfo(with: currentUsers[indexPath.row])
        cell.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    
    required init?(coder:NSCoder){
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        userProfilePhoto.maskCircle(anyImage: UIImage(named: "ProfileImage")!)
        
        let nib = UINib(nibName: "FriendsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "UserInfo")
        
    }
    
    
    @IBAction func segmentedControlChanged(_ sender: Any) {
        if segmentedControl.selectedSegmentIndex == 0 {
            print("Post")
        } else if segmentedControl.selectedSegmentIndex == 1 {
            print("Followers")
        } else {
            print("Following")
        }
    }
    
    @IBAction func unwindToProfilePageViewController(_ unwindSegue: UIStoryboardSegue) {
        
    }

}
