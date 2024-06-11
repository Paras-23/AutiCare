

import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage


class CreateAccountTableViewController: UITableViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var ProfileImageView: UIImageView!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet var phoneNumberTextField: UITextField!
    
    @IBOutlet weak var genderButton: UIButton!
    
    let storage = Storage.storage()
    let database = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        phoneNumberTextField.delegate = self
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        usernameTextField.delegate = self
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
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
            return 7
        default:
            return 0
        }
        
    }
    
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
        guard let email = emailTextField.text else{return}
        guard let password = passwordTextField.text else {return}
        guard let firstName = firstNameTextField.text else {return}
        guard let LastName = lastNameTextField.text else {return}
        guard let username = usernameTextField.text else{return}
        guard (genderButton.titleLabel?.text) != nil else{return}
        guard let phoneNo = phoneNumberTextField.text else {return}
        
        
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let _ = error{
                print("error")
            }
            else{
                let usersRef = Database.database().reference().child("users")
                if let uid = Auth.auth().currentUser?.uid{
                    self.uploadUserDataToFirebase(image: self.ProfileImageView.image! , uid: uid)
                    let userData = User(UserID: UUID(), firstName: firstName, lastName: LastName, userName: username, emailAddress: email, password: password, phone: phoneNo, profilePictureURL: nil , coverPicture: nil, location: nil, gender: self.genderButton.currentTitle!, age: nil, bio: nil, following: nil, followers: nil, posts: nil)
                
                    //user is logged in
                    usersRef.child(uid).updateChildValues(userData.toDictionary()){error,ref in print("User data uploaded")}
                    
                }
                self.dismiss(animated: true, completion: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let mainVC = storyboard.instantiateViewController(withIdentifier: "mainPage") as? UITabBarController  {
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
    
    func uploadUserDataToFirebase(image: UIImage , uid : String) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return  }
        
        let storageRef = storage.reference().child("images/\(UUID().uuidString).jpg")
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            guard metadata != nil else {
                print("Failed to upload")
                return
            }
            storageRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("Failed to retrieve download URL")
                    return
                }
                self.saveImageURLToDatabase(uid: uid, url: downloadURL.absoluteString)
            }
        }
    }
    
    func saveImageURLToDatabase(uid: String, url: String) {
        database.child("users").child(uid).child("profilePicture").setValue(url) { error, _ in
            if let error = error {
                print("Failed to save image URL to database: \(error)")
                return
            }
            
            print("Successfully saved image URL to database")
        }
    }
}

