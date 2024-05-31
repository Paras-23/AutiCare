//
//  AddNewPostViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 31/05/24.
//

import UIKit

class AddNewPostViewController: UIViewController {

    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var newPostImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.layer.borderColor = UIColor(named: "White")?.cgColor
    

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
