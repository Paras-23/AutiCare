//
//  ProgressPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit
import SwiftUI

class ProgressPageViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    required init?(coder : NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "Progress"
        self.tabBarItem.image = UIImage(systemName: "chart.line.uptrend.xyaxis.circle")
    }
    
    @IBOutlet var assessmentStack: UIStackView!
    
    @IBOutlet var homeStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if autismLevel.text == "Autism Level" {
        //            assessmentStack.isHidden = false
        //            homeStack.isHidden = true
        //        }
    }
       
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func unwindToProgressPageViewController(segue: UIStoryboardSegue) {
        
        assessmentStack.isHidden = true
        homeStack.isHidden = false
        // Use data from the view controller which initiated the unwind segue
    }
}
