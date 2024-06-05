//
//  HostViewController.swift
//  AutiCare
//
//  Created by sourav_singh on 05/06/24.
//

import UIKit
import SwiftUI

class HostViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!

        override func viewDidLoad() {
            super.viewDidLoad()

            let calendarView = CalendarView()
            let hostingController = UIHostingController(rootView: calendarView)
            
            addChild(hostingController)
            hostingController.view.translatesAutoresizingMaskIntoConstraints = false
            containerView.addSubview(hostingController.view)
            
            NSLayoutConstraint.activate([
                hostingController.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                hostingController.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                hostingController.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                hostingController.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            
            hostingController.didMove(toParent: self)
        }
    }

