//
//  InstructionsViewController.swift
//  AutiCare
//
//  Created by Sudhanshu Singh Rajput on 11/06/24.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var instructions: UILabel!
    var gameInfo : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instructions.text = gameInfo

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
