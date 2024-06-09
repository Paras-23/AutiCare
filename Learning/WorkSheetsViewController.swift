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

    }
    
    func saveImageToFileSystem(image: UIImage, as type: String) -> URL? {
        let fileManager = FileManager.default
        let tempDirectory = fileManager.temporaryDirectory
        
        var imageData: Data?
        var fileExtension: String
        
        switch type.lowercased() {
        case "png":
            imageData = image.pngData()
            fileExtension = "png"
        case "jpeg", "jpg":
            imageData = image.jpegData(compressionQuality: 1.0)
            fileExtension = "jpg"
        default:
            return nil
        }
        
        let imageURL = tempDirectory.appendingPathComponent("worksheet.\(fileExtension)")
        
        do {
            try imageData?.write(to: imageURL)
            return imageURL
        } catch {
            print("Could not save image file: \(error)")
            return nil
        }
    }
    
    func shareImage(imageURL: URL) {
        let activityVC = UIActivityViewController(activityItems: [imageURL], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view // For iPad support
        present(activityVC, animated: true, completion: nil)
    }
    
    @IBAction func downloadImageButtonTapped(_ sender: UIBarButtonItem) {
        if let image = worksheetImageView.image {
            if let imageURL = saveImageToFileSystem(image: image, as: "png") {
                shareImage(imageURL: imageURL)
            } else {

                let alert = UIAlertController(title: "Error", message: "Could not save image", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    }


}
