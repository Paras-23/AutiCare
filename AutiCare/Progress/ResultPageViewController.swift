//
//  ResultPageViewController.swift
//  AutiCare
//
//  Created by Batch-2 on 28/05/24.
//

import UIKit

import Charts
struct SectorMark {
    let data = [
        (name: "Cachapa", sales: 9631),
        (name: "Crêpe", sales: 6959),
        (name: "Injera", sales: 4891),
        (name: "Jian Bing", sales: 2506),
        (name: "American", sales: 1777),
        (name: "Dosa", sales: 625),
    ]
    
//    var body: some View {
//        Chart(data, id: \.name) { name, sales in
//            SectorMark(angle: .value("Value", sales))
//                .foregroundStyle(by: .value("Product category", name))
//        }
//    }
}

class ResultPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
