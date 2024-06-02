//
//  AddNewPostViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 31/05/24.
//

import UIKit

class AddNewPostViewController: UIViewController, UINavigationControllerDelegate {

    @IBOutlet var captionTextField: UITextField!
    @IBOutlet var newPostImage: UIImageView!
    @IBOutlet var viewForImageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captionTextField.layer.borderColor = UIColor(named: "White")?.cgColor
    

        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangePostImage))
        viewForImageView.addGestureRecognizer(gesture)
    }
    
    @objc private func didTapChangePostImage() {
            presentPhotoActionsheet()
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
        else {return}
        
        self.newPostImage.image = selectedImage
        self.dismiss(animated: true, completion: nil)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true, completion: nil)
        }
    }
