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
        pieChart()
        // Do any additional setup after loading the view.
    }
    
    func pieChart(){
        let data: [CGFloat] = [10, 130 ,10, 30, 40]
        let colors: [UIColor] = [.red, .blue, .purple , .green, .gray]
        
        let titles: [String] = ["Red", "Blue", "Green", "Yellow" , "purple"]
        
        pieChartView.data = data
        pieChartView.colors = colors
        pieChartView.titles = titles
        pieChartView.innerRadiusRatio = 0.5 // Adjust this value to change the inner radius
        pieChartView.separationAngle = 2 * .pi / 180 // Adjust this value to change the separation angle
        //pieChartView.cornerRadius = 10 // Adjust this value to change the corner radius
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
