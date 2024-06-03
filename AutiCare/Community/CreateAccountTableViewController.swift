

import UIKit
import FirebaseAuth
import FirebaseDatabase


class CreateAccountTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var genderButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return 1
        case 1:
            return 5
        default:
            return 0
        }
        
    }
    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else {return}
        guard let name = nameTextField.text else {return}
        guard let username = usernameTextField.text else{return}
        guard let gender = genderButton.titleLabel?.text else{return}
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let e = error{
                print("error")
            }
            else{
                let usersRef = Database.database().reference().child("user")
                let userData = ["email":self.emailTextField.text!,"password":self.passwordTextField.text!,"name":self.nameTextField.text!,"username":self.usernameTextField.text!,"Gender":self.genderButton.titleLabel?.text]
                if let uid = Auth.auth().currentUser?.uid{
                    //user is logged in
                    usersRef.child(uid).updateChildValues(userData as [AnyHashable : Any]){error,ref in print("User data uploaded")}}
                /*self.performSegue(withIdentifier: "createdAccount", sender: self)*/
                self.dismiss(animated: true, completion: nil)
                
            }
            
        }
    }
    
    
    @IBAction func genderButtonTapped(_ sender: Any) {
        
        
    }
    
    @IBAction func addImage(_ sender: Any) {
        
        let imagePicker = UIImagePickerController ()
        imagePicker.delegate = self
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction (title: "Cancel" , style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraAction = UIAlertAction (title: "Camera", style: .default, handler: { action in imagePicker.sourceType = .camera
                self.present (imagePicker, animated: true, completion: nil)
            } )
            alertController.addAction (cameraAction)
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                imagePicker.sourceType = .photoLibrary
                self.present (imagePicker, animated: true, completion: nil)
            })
            alertController.addAction(photoLibraryAction)
        }
        alertController.popoverPresentationController?.sourceView = sender as? UIView
        present(alertController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {return}
        ProfileImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

