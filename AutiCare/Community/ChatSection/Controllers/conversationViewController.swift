//
//  ViewController.swift
//  ChatApp
//
//  Created by sourav_singh on 21/05/24.
//

import UIKit
import FirebaseAuth

class ConversationsViewController: UIViewController {
    
    // private let spinner = JGProgressHUD(style: .dark)
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self,forCellReuseIdentifier: "cell"
        )
        return table
    } ()
    
    //    private let noConversationsLabel: UILabel = {
    //        let label = UILabel()
    //        label.text = "No Conversation!"
    //        label.textAlignment = .center
    //        label.textColor = .gray
    //        label.font = .systemFont(ofSize: 21, weight: .medium)
    //        label.isHidden = true
    //        return label
    //    }
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        view.addSubview(tableView)
//        setuptableView()
        //                fetchConversations()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }
}
        
//            private func setuptableView() {
//
//                tableView.delegate = self
//                tableView.dataSource = self
//            }
        
