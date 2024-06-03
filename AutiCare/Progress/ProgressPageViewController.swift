//
//  ProgressPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class ProgressPageViewController: UIViewController {
    
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
        if autismLevel.text == "Autism Level" {
            assessmentStack.isHidden = false
            homeStack.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func unwindToProgressPageViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AssessmentTableViewController
        
        assessmentStack.isHidden = true
        homeStack.isHidden = false
        autismLevel.text = "Autism Score - \(sourceViewController.autismScore)/200"
        // Use data from the view controller which initiated the unwind segue
    }
}
