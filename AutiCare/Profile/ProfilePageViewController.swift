//
//  ProfilePageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.width/2.0
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = anyImage
    }
}
class ProfilePageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "\(profile[indexPath.row])"
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // imageView outlet
    
    @IBOutlet weak var circularImageView: UIImageView!
    //tableView Outlet
    
    @IBOutlet weak var profileTableView: UITableView!
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Profile"
        self.tabBarItem.image = UIImage(systemName: "person.crop.circle")    }
    
    var profile :[String] = ["User Info","Notifications","Share","Settings","About Us","Log Out"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let profile = UIImage(named: "1")!
        circularImageView.maskCircle(anyImage: profile)
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
        
    }
    @IBAction func unwindToProfilePageViewController(segue: UIStoryboardSegue) {
        
        // Use data from the view controller which initiated the unwind segue
    }
}
