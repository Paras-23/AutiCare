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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        autismScore.text = "\((assessmentResults.last?.scores.reduce(0){$0 + $1})!)"
        pieChart()
        // Do any additional setup after loading the view.
    }
    
    func pieChart(){
        let data: [CGFloat] = (assessmentResults.last?.scores.map { CGFloat($0) })!
        let colors: [UIColor] = [.red, .blue, .purple , .green, .gray , .cyan]
        
        let titles: [String] = ["Social" , "Emotional" , "Speech" , "Behaviour" , "Sensory" , "Cognitive"]
        
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

}
