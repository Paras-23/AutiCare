//
//  matchingViewController.swift
//  AutiCare
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit

class matchingGameViewController: UIViewController {
    
    // Outlets for the top row images
    @IBOutlet weak var lionImageView: UIImageView!
    @IBOutlet weak var catImageView: UIImageView!
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var scooterImageView: UIImageView!
    
    // Outlets for the bottom row buttons
    @IBOutlet weak var helmetButton: UIButton!
    @IBOutlet weak var boneButton: UIButton!
    @IBOutlet weak var fishButton: UIButton!
    @IBOutlet weak var rocksButton: UIButton!
    
    // Array to store correct matches
    var correctMatches: [UIButton: UIImageView] = [:]
    
    // Store lines to remove them if necessary
    var lines: [CAShapeLayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Define the correct matches
        correctMatches = [
            helmetButton: scooterImageView,
            boneButton: dogImageView,
            fishButton: catImageView,
            rocksButton: lionImageView
        ]
        
        // Set images for the top row (for demonstration purposes)
        lionImageView.image = UIImage(named: "lion")
        catImageView.image = UIImage(named: "cat")
        dogImageView.image = UIImage(named: "dog")
        scooterImageView.image = UIImage(named: "scooter")
        
        // Set images for the bottom row buttons (for demonstration purposes)
        helmetButton.setImage(UIImage(named: "helmet"), for: .normal)
        boneButton.setImage(UIImage(named: "bone"), for: .normal)
        fishButton.setImage(UIImage(named: "fish"), for: .normal)
        rocksButton.setImage(UIImage(named: "rocks"), for: .normal)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        guard let correctImageView = correctMatches[sender] else { return }
        
        if sender == helmetButton && correctImageView == scooterImageView ||
           sender == boneButton && correctImageView == dogImageView ||
           sender == fishButton && correctImageView == catImageView ||
           sender == rocksButton && correctImageView == lionImageView {
            // The match is correct
            showMarker(on: sender, with: UIImage(named: "checkmark"))
            drawLine(from: sender, to: correctImageView)
        } else {
            // The match is incorrect
            showMarker(on: sender, with: UIImage(named: "crossmark"))
        }
    }
    
    func showMarker(on button: UIButton, with image: UIImage?) {
        let overlayImageView = UIImageView(image: image)
        overlayImageView.frame = CGRect(x: button.bounds.midX - 20, y: button.bounds.midY - 20, width: 40, height: 40)
        overlayImageView.contentMode = .scaleAspectFit
        overlayImageView.tag = 100 // Set a tag to identify the overlay
        button.addSubview(overlayImageView)
    }
    
    func removeMarkers(from button: UIButton) {
        for subview in button.subviews {
            if subview.tag == 100 {
                subview.removeFromSuperview()
            }
        }
    }
    
    func removeAllMarkers() {
        for button in correctMatches.keys {
            removeMarkers(from: button)
        }
    }
    
    func drawLine(from button: UIButton, to imageView: UIImageView) {
        let linePath = UIBezierPath()
        let startPoint = view.convert(button.center, from: button.superview)
        let endPoint = view.convert(imageView.center, from: imageView.superview)
        linePath.move(to: startPoint)
        linePath.addLine(to: endPoint)
        
        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.blue.cgColor
        lineLayer.lineWidth = 2.0
        
        view.layer.addSublayer(lineLayer)
        lines.append(lineLayer)
    }
    
    func removeAllLines() {
        for line in lines {
            line.removeFromSuperlayer()
        }
        lines.removeAll()
    }
}

