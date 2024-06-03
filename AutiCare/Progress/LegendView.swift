//
//  PieChartColourDetailsUIView.swift
//  AutiCare
//
//  Created by Batch-1 on 03/06/24.
//

import UIKit

class LegendView: UIView {
    
    var titles: [String] = []
    var colors: [UIColor] = []
    
    init(frame: CGRect, titles: [String], colors: [UIColor]) {
        self.titles = titles
        self.colors = colors
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupLegend()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
        setupLegend()
    }
    
    private func setupLegend() {
        guard titles.count == colors.count else {
            return
        }
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for (index, title) in titles.enumerated() {
            let colorView = UIView()
            colorView.backgroundColor = colors[index]
            colorView.widthAnchor.constraint(equalToConstant: 10).isActive = true
            colorView.heightAnchor.constraint(equalToConstant: 10).isActive = true
            
            let label = UILabel()
            label.text = title
            label.font = UIFont.systemFont(ofSize: 15)
            label.textColor = .black
            
            let horizontalStack = UIStackView(arrangedSubviews: [colorView, label])
            horizontalStack.axis = .horizontal
            horizontalStack.alignment = .center
            horizontalStack.spacing = 15
            
            stackView.addArrangedSubview(horizontalStack)
        }
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
