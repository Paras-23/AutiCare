import UIKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class EditProfileTableViewController: UITableViewController, UINavigationControllerDelegate {

    @IBOutlet var coverImageView: UIImageView!
    @IBOutlet var firstNameTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var lastNameTextField: UITextField!
    @IBOutlet var userNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var genderButtonTapped: UIButton!
    @IBOutlet var viewForProfile: UIView!
    @IBOutlet var viewForCover: UIView!
    
    var profileImageUrl: String?
    var coverImageUrl: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        existingInfo()
        
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        let profileGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeImage(_:)))
        viewForProfile.tag = ImageType.profile.rawValue
        viewForProfile.addGestureRecognizer(profileGesture)

        let coverGesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeImage(_:)))
        viewForCover.tag = ImageType.cover.rawValue
        viewForCover.addGestureRecognizer(coverGesture)
    }
    
    @objc private func didTapChangeImage(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view else {
            return
        }
        
        switch view.tag {
        case ImageType.profile.rawValue:
            presentPhotoActionsheet(for: .profile)
        case ImageType.cover.rawValue:
            presentPhotoActionsheet(for: .cover)
        default:
            break
        }
    }
    
    func existingInfo() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        let postsRef = Database.database().reference().child("users").child(uid)
        postsRef.observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let self = self else { return }
            guard snapshot.exists() else {
                return
            }
            guard let value = snapshot.value as? [String: Any] else {
                return
            }

            if let profileImage = value["profilePicture"] as? String,
               let first = value["firstName"] as? String,
               let last = value["lastName"] as? String,
               let username = value["userName"] as? String,
               let email = value["emailAddress"] as? String,
               let password = value["password"] as? String {
                if let imageURL = URL(string: profileImage) {
                    self.profileImage.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "reload")) { image, error, _, _ in
                        if let error = error {
                            print("Failed to load profile image: \(error)")
                        } else {
                            self.profileImage.maskWhiteCircle(anyImage: image!)
                        }
                    }
                }
                self.firstNameTextField.text = first
                self.lastNameTextField.text = last
                self.emailTextField.text = email
                self.passwordTextField.text = password
                self.userNameTextField.text = username
            } else {
                print("One or more fields are missing in the data")
            }
            if let coverImg = value["coverPicture"] as? String {
                if let imageUrl = URL(string: coverImg) {
                    self.coverImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "reload"))
                }
            }
        } withCancel: { error in
            print("Failed to fetch user data: \(error)")
        }
    }
    
    

    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        print("Save button tapped")
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        var uploadCounter = 0
        
        if let profileImage = profileImage.image {
            uploadImage(image: profileImage, imageType: .profile) { [weak self] url in
                if let url = url {
                    self?.profileImageUrl = url
                    uploadCounter += 1
                    if uploadCounter == 2 {
                        self?.updateUserData(uid: uid)
                    }
                }
            }
        }
        
        if let coverImage = coverImageView.image {
            uploadImage(image: coverImage, imageType: .cover) { [weak self] url in
                if let url = url {
                    self?.coverImageUrl = url
                    uploadCounter += 1
                    if uploadCounter == 2 {
                        self?.updateUserData(uid: uid)
                    }
                }
            }
        }
        
        
    }

    func uploadImage(image: UIImage, imageType: ImageType, completion: @escaping (String?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(imageType == .profile ? "profile" : "cover")_\(UUID().uuidString).jpg")
        
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Failed to get download URL: \(error)")
                completion(nil)
                return
            }
            
            print("Download URL: \(url?.absoluteString ?? "nil")")
            completion(url?.absoluteString)
        }
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error)")
                completion(nil)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Failed to get download URL: \(error)")
                    completion(nil)
                    return
                }
                
                completion(url?.absoluteString)
            }
        }
    }

    func updateUserData(uid: String) {
        
        print("Updating user data...")
        
        var updates: [String: Any] = [
            "firstName": firstNameTextField.text ?? "",
            "lastName": lastNameTextField.text ?? "",
            "userName": userNameTextField.text ?? "",
            "emailAddress": emailTextField.text ?? "",
            "password": passwordTextField.text ?? "",
            "fullName" : firstNameTextField.text! + " " + lastNameTextField.text!
        ]
        if let profileImageUrl = profileImageUrl {
            updates["profilePicture"] = profileImageUrl
        }
        
        if let coverImageUrl = coverImageUrl {
            updates["coverPicture"] = coverImageUrl
        }
        
        Database.database().reference().child("users").child(uid).updateChildValues(updates) { error, _ in
            if let error = error {
                print("Failed to update user data: \(error)")
            } else {
                print("User data updated successfully")
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return 5
        default: return 0
        }
    }
}

extension EditProfileTableViewController:  UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    func presentPhotoActionsheet(for imageType: ImageType) {
        let actionSheet = UIAlertController(title: "", message: "Select a photo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{ [weak self] _ in
            self?.presentCamera(for: imageType)
        }))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker(for: imageType)
        }))
        present(actionSheet, animated: true)
    }
    
    func presentCamera(for imageType: ImageType) {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        vc.view.tag = imageType.rawValue
        present(vc, animated: true)
    }
    
    func presentPhotoPicker(for imageType: ImageType) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        vc.view.tag = imageType.rawValue
        present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else {
            return
        }
        
        if picker.view.tag == ImageType.profile.rawValue {
            self.profileImage.image = selectedImage
        } else if picker.view.tag == ImageType.cover.rawValue {
            self.coverImageView.image = selectedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

enum ImageType : Int{
    case profile = 1
    case cover = 2
}

