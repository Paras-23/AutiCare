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
        
        let postImage = newPostImage.image!
        let caption = captionTextField.text!
        
        uploadPost(image: postImage, caption: caption, userID: uid!){success in
            if success {
                print("Post uploaded successfully")
            } else {
                print("Failed to upload post")
            }
        }
        
        dismiss(animated: true, completion: nil)
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
    
    
    func uploadPost(image: UIImage, caption: String, userID: String, completion: @escaping (Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(false)
            return
        }
        
        let postID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(userID).child("\(postID).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let downloadURL = url else {
                    print("Download URL is nil")
                    completion(false)
                    return
                }
                
                let post = Post(postID: postID, userID: userID, caption: caption, imageURL: downloadURL.absoluteString, timestamp: Date().timeIntervalSince1970)
                
                let postRef = Database.database().reference().child("user").child(userID).child("posts").child(postID)
                postRef.setValue(post.toDictionary()) { error, ref in
                    if let error = error {
                        print("Error saving post: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }


}

