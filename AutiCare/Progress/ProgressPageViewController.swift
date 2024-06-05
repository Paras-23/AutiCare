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
    
    @IBOutlet var autismLevel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if autismLevel.text == "Autism Level" {
//            assessmentStack.isHidden = false
//            homeStack.isHidden = true
//        }
        
        let calendarView = CalendarView()
        let hostingController = UIHostingController(rootView: calendarView)
        
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(hostingController.view)
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func unwindToProgressPageViewController(segue: UIStoryboardSegue) {
        
        assessmentStack.isHidden = true
        homeStack.isHidden = false
        autismLevel.text = "Autism Score - \((assessmentResults.last?.scores.reduce(0){$0 + $1})!)/200"
        // Use data from the view controller which initiated the unwind segue
    }
}
