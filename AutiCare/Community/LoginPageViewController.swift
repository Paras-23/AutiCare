//
//  LoginPageViewController.swift
//  AutiCare
//
//  Created by Sudhanshu Singh Rajput on 04/06/24.
//
//


import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginPageViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.tintColor = UIColor.init(red: 0.001, green: 0.301, blue: 0.500, alpha: 1)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        print("a")
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else {return}
        
        
        
            Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let _ = error{
                print("error")
                let alert = UIAlertController(title: "Error", message: "Invalid login details", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Try Again", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            else{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let mainVC = storyboard.instantiateViewController(withIdentifier: "mainPage") as? UITabBarController {
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let window = windowScene.windows.first else {
                        return
                    }
                    window.rootViewController = mainVC
                    window.makeKeyAndVisible()
                }
            }
               
        }
    }
}

