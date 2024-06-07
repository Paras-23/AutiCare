//
//  SplashScreenViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 05/06/24.


import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkAuthenticationStatus()
    }

    private func checkAuthenticationStatus() {
        if Auth.auth().currentUser != nil {
            // User is signed in, navigate to the main page
            navigateToMainScreen()
        } else {
            // No user is signed in, navigate to the login screen
            navigateToLoginScreen()
        }
    }

    private func navigateToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainVC = storyboard.instantiateViewController(withIdentifier: "mainPage") as? UITabBarController  {
            setRootViewController(mainVC)
        }
    }

    private func navigateToLoginScreen() {
        let storyboard = UIStoryboard(name: "auth", bundle: nil)
        if let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginPage") as?  LoginPageViewController {
            setRootViewController(loginVC)
        }
    }
    
    private func setRootViewController(_ viewController: UIViewController) {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }
            window.rootViewController = viewController
            window.makeKeyAndVisible()
        }
}

