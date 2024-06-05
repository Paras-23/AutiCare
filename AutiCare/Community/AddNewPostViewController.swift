//
//  AddNewPostViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 31/05/24.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class AddNewPostViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var newPostImage: UIImageView!
    @IBOutlet var viewForImageView: UIView!
    
    let storage = Storage.storage()
    let database = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid // Make sure user is logged in and you have their UID
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.layer.borderColor = UIColor(named: "White")?.cgColor
    

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangePostImage))
        viewForImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangePostImage() {
            presentPhotoActionsheet()
    }
    
    @IBAction func sharePostTapped(_ sender: Any) {
        
        let exampleImage = newPostImage.image!
        let caption = captionTextField.text!
        
        PostService.uploadPost(image: exampleImage, caption: caption) { success in
            if success {
                print("Post uploaded successfully")
            } else {
                print("Failed to upload post")
            }
        }
        
    }
    
    
}

extension AddNewPostViewController:  UIImagePickerControllerDelegate {
    
    func presentPhotoActionsheet() {
        let actionSheet = UIAlertController(title: "New Post", message: "Select a photo", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:{[weak self]_ in
            self?.presentCamera()
        } ))
        actionSheet.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { [weak self] _ in
            self?.presentPhotoPicker()
        } ))
        present(actionSheet, animated: true)
    }
    
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated:  true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        else {
            return
        }
        
        self.newPostImage.image = selectedImage
        self.dismiss(animated: true, completion: nil)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    
    func uploadPostImageToFirebase(image: UIImage) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
        
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
                
                self.saveImageURLToDatabase(url: downloadURL.absoluteString)
            }
        }
    }
    
    func saveImageURLToDatabase(url: String) {
        database.child("Posts").child(uid!).child("fullName").setValue(url) { error, _ in
            if let error = error {
                print("Failed to save image URL to database: \(error)")
                return
            }
            
            print("Successfully saved image URL to database")
        }
    }
}

