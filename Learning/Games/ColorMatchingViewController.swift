//
//  ColorMatchingViewController.swift
//  AutiCare
//
//  Created by Sudhanshu Singh Rajput on 06/06/24.
//

import UIKit

class ColorMatchingViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }

    
     var shapes: [UIView] = []
         var targets: [UIView] = []
         var currentLevel = 1
         let maxLevel = 3
         let shapeColors: [UIColor] = [.red, .blue, .green]
         let shapeTypes: [ShapeType] = [.square, .triangle, .circle]
         
         enum ShapeType {
             case square, triangle, circle
         }
         
         let titleLabel: UILabel = {
             let label = UILabel()
             label.text = "Shape Sorting"
             label.font = UIFont.boldSystemFont(ofSize: 24)
             label.textAlignment = .center
             return label
         }()
         
         let levelLabel: UILabel = {
             let label = UILabel()
             label.text = "Level 1"
             label.font = UIFont.systemFont(ofSize: 18)
             label.textAlignment = .center
             return label
         }()
         
         let playButton: UIButton = {
             let button = UIButton(type: .system)
             button.setTitle("Play", for: .normal)
             button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
             button.setTitleColor(.white, for: .normal)
             button.backgroundColor = .systemBlue
             button.layer.cornerRadius = 10
             button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
             return button
         }()
         
         override func viewDidLoad() {
             super.viewDidLoad()
             setupUI()
         }
         
         func setupUI() {
             view.backgroundColor = .white
             
             titleLabel.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(titleLabel)
             NSLayoutConstraint.activate([
                 titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                 titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
             ])
             
             levelLabel.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(levelLabel)
             NSLayoutConstraint.activate([
                 levelLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
                 levelLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
             ])
             
             playButton.translatesAutoresizingMaskIntoConstraints = false
             view.addSubview(playButton)
             NSLayoutConstraint.activate([
                 playButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
                 playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                 playButton.widthAnchor.constraint(equalToConstant: 100),
                 playButton.heightAnchor.constraint(equalToConstant: 50)
             ])
         }
         
         @objc func playButtonTapped() {
             startLevel(currentLevel)
         }
         
         func startLevel(_ level: Int) {
             clearShapes()
             levelLabel.text = "Level \(level)"
             
             let shapesAndTargets = generateShapesAndTargets(for: level)
             
             for (index, (shape, target)) in shapesAndTargets.enumerated() {
                 shape.backgroundColor = shapeColors.randomElement()
                 target.backgroundColor = .clear
                 target.layer.borderWidth = 2
                 target.layer.borderColor = shape.backgroundColor?.cgColor
                 
                 let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                 shape.addGestureRecognizer(panGesture)
                 shape.isUserInteractionEnabled = true
                 
                 shapes.append(shape)
                 targets.append(target)
                 
                 let shapeXPosition = CGFloat(20 + index * 110)
                 shape.frame.origin = CGPoint(x: shapeXPosition, y: 200)
                 target.frame.origin = CGPoint(x: shapeXPosition, y: 350)
                 
                 view.addSubview(shape)
                 view.addSubview(target)
             }
         }
         
         func generateShapesAndTargets(for level: Int) -> [(shape: UIView, target: UIView)] {
             var shapesAndTargets: [(shape: UIView, target: UIView)] = []
             let numberOfShapes = level
             var usedShapes: [ShapeType] = []
             
             for _ in 0..<numberOfShapes {
                 let shapeType: ShapeType = shapeTypes[usedShapes.count]
                 usedShapes.append(shapeType)
                 
                 let shape = createShape(type: shapeType, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                 let target = createShape(type: shapeType, frame: CGRect(x: 0, y: 0, width: 100, height: 100))
                 shapesAndTargets.append((shape, target))
             }
             
             return shapesAndTargets
         }
         
         func createShape(type: ShapeType, frame: CGRect) -> UIView {
             let shape = UIView(frame: frame)
             switch type {
             case .circle:
                 shape.layer.cornerRadius = frame.width / 2
             case .square:
                 break
             case .triangle:
                 let path = UIBezierPath()
                 path.move(to: CGPoint(x: frame.width / 2, y: 0))
                 path.addLine(to: CGPoint(x: frame.width, y: frame.height))
                 path.addLine(to: CGPoint(x: 0, y: frame.height))
                 path.close()
                 
                 let shapeLayer = CAShapeLayer()
                 shapeLayer.path = path.cgPath
                 shape.layer.mask = shapeLayer
             }
             return shape
         }
         
         @objc func handlePan(_ sender: UIPanGestureRecognizer) {
             guard let draggedView = sender.view else { return }
             let translation = sender.translation(in: view)
             draggedView.center = CGPoint(x: draggedView.center.x + translation.x, y: draggedView.center.y + translation.y)
             sender.setTranslation(.zero, in: view)
             
             if sender.state == .ended {
                 checkForMatch(draggedView)
             }
         }
         
         func checkForMatch(_ draggedView: UIView) {
             for target in targets {
                 if draggedView.frame.intersects(target.frame) && target.layer.borderColor == draggedView.backgroundColor?.cgColor {
                     showAlert(title: "Correct", message: "You matched the shape!", completion: {
                         self.shapes.removeAll { $0 == draggedView }
                         draggedView.removeFromSuperview()
                         self.checkLevelCompletion()
                     })
                     return
                 }
             }
             showAlert(title: "Try Again", message: "The shape does not match.")
         }
         
         func checkLevelCompletion() {
             if shapes.isEmpty {
                 nextLevel()
             }
         }
         
         func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
             let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                 completion?()
             }))
             present(alert, animated: true, completion: nil)
         }
         
         func clearShapes() {
             for shape in shapes {
                 shape.removeFromSuperview()
             }
             for target in targets {
                 target.removeFromSuperview()
             }
             shapes.removeAll()
             targets.removeAll()
         }
         
         func nextLevel() {
             if currentLevel < maxLevel {
                 currentLevel += 1
                 startLevel(currentLevel)
             } else {
                 showAlert(title: "Congratulations!", message: "You've completed all levels!") {
                     self.currentLevel = 1
                     self.performSegue(withIdentifier: "ColorMatchingGameUnwindToLearningPage", sender: nil)
                 }
             }
         }

}
