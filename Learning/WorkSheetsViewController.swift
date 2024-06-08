//
//  WorkSheetsViewController.swift
//  AutiCare
//
//  Created by Abcom on 08/06/24.
//

import UIKit

class WorkSheetsViewController: UIViewController {

    @IBOutlet var worksheetImageView: UIImageView!
    @IBOutlet var worksheetTitle: UILabel!
    
    var selectedWorksheet : Worksheet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        worksheetImageView.image = UIImage(named: selectedWorksheet!.worksheetImage)
        worksheetTitle.text = selectedWorksheet?.worksheetName

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
