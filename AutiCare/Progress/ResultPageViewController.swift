//
//  ResultPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 28/05/24.
//

import UIKit

class ResultPageViewController: UIViewController {
    
    
    @IBOutlet var autismScore: UILabel!
    @IBOutlet var autismLevel: UILabel!
    @IBOutlet var autismLevelDescription: UILabel!
    
    @IBOutlet var pieChartView: PieChartUIView!
    @IBOutlet weak var legendContainerView: UIView!
    
    @IBOutlet var activityRecommender: UILabel!
    
    let colors: [UIColor] = [.red, .blue, .purple , .green, .gray , .cyan]
    let titles: [String] = ["Social" , "Emotional" , "Speech" , "Behaviour" , "Sensory" , "Cognitive"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autismScore.text = "\((assessmentResults.last?.totalScore)!)"
        pieChart()
        
        switch (assessmentResults.last?.totalScore)! {
        case 1..<70:
            autismLevel.text = "No Indication of Autism"
            autismLevelDescription.text  = results[0]
        case 70...106:
            autismLevel.text = "Indication of Mild Autism"
            autismLevelDescription.text  = results[1]
        case 107...153:
            autismLevel.text = "Indication of Moderate Autism"
            autismLevelDescription.text  = results[2]
        default:
            autismLevel.text = "Indication of Severe Autism"
            autismLevelDescription.text = results[3]
            
        }
        
        if let (maxIndex, _) = (assessmentResults.last?.scores)!.enumerated().max(by: {$0.element < $1.element}) {
            let category = titles[maxIndex]
            activityRecommender.text = "Your score in \(category) category is higher. We suggest you to focus more on \(category) activities."
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    func pieChart(){
        let data: [CGFloat] = (assessmentResults.last?.scores.map { CGFloat($0)})!
        
        pieChartView.data = data
        pieChartView.colors = colors
        pieChartView.titles = titles
        pieChartView.innerRadiusRatio = 0.6 // Adjust this value to change the inner radius
        pieChartView.separationAngle = 2 * .pi / 180 // Adjust this value to change the separation angle
        pieChartView.setNeedsDisplay()
        
        let legendView = LegendView(frame: legendContainerView.bounds, titles: titles, colors: colors)
        legendView.translatesAutoresizingMaskIntoConstraints = false
        legendContainerView.addSubview(legendView)
        NSLayoutConstraint.activate([
            legendView.leadingAnchor.constraint(equalTo: legendContainerView.leadingAnchor),
            legendView.trailingAnchor.constraint(equalTo: legendContainerView.trailingAnchor),
            legendView.topAnchor.constraint(equalTo: legendContainerView.topAnchor),
            legendView.bottomAnchor.constraint(equalTo: legendContainerView.bottomAnchor)
        ])
    }
    

    @IBAction func continueButtonTapped(_ sender: UIButton) {
    }
    
}
