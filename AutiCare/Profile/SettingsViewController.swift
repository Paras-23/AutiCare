//
//  SettingsViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 07/06/24.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SettingsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCellSettings", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Log out"
        cell.contentConfiguration = content
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        logoutButtonTapped()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func logoutButtonTapped() {
       do {
           try Auth.auth().signOut()
           // Navigate to the login screen or update the UI
           navigateToLoginScreen()
       } catch let signOutError as NSError {
           print("Error signing out: %@", signOutError)
           // Show an alert to the user or handle the error as needed
           showLogoutErrorAlert(error: signOutError)
       }
   }
    
    func navigateToLoginScreen() {
            // Assuming you are using a storyboard, you can instantiate the login view controller
            let storyboard = UIStoryboard(name: "auth", bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginPage") as! LoginPageViewController
            loginViewController.modalPresentationStyle = .fullScreen
            self.present(loginViewController, animated: true, completion: nil)
        }

        func showLogoutErrorAlert(error: NSError) {
            let alert = UIAlertController(title: "Logout Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
