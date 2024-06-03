//
//  PieChartUIView.swift
//  AutiCare
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit

class PieChartUIView: UIView {
    
    var data: [CGFloat] = []
    var colors: [UIColor] = []
    var titles: [String] = []
    var innerRadiusRatio: CGFloat = 0.5 // Ratio for the inner radius (0.5 means half of the outer radius)
    var separationAngle: CGFloat = 2 * .pi / 180 // Separation angle between slices (in radians)

    init(frame: CGRect, data: [CGFloat], colors: [UIColor], titles: [String], innerRadiusRatio: CGFloat = 0.5, separationAngle: CGFloat = 2 * .pi / 180, cornerRadius: CGFloat = 10) {
        self.data = data
        self.colors = colors
        self.titles = titles
        self.innerRadiusRatio = innerRadiusRatio
        self.separationAngle = separationAngle
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }

    override func draw(_ rect: CGRect) {
        guard data.count == colors.count && data.count == titles.count else {
            return
        }
        
        let total = data.reduce(0, +)
        guard total > 0 else {
            return
        }
        
        let center = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
        let outerRadius = min(bounds.size.width, bounds.size.height) / 2
        let innerRadius = outerRadius * innerRadiusRatio
        var startAngle = -CGFloat.pi / 2

        for (index, value) in data.enumerated() {
            let endAngle = startAngle + 2 * .pi * (value / total)
            let path = UIBezierPath()
            path.addArc(withCenter: center, radius: outerRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            path.addArc(withCenter: center, radius: innerRadius, startAngle: endAngle, endAngle: startAngle, clockwise: false)
            path.close()

            colors[index].setFill()
            path.fill()
            
            startAngle = endAngle + separationAngle
        }
    }
}
