//
//  LearningDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation

struct Games{
    var imageName:String
}
struct Sessions{
    var imageName:String
}
struct Worksheets{
    var imageName:String
}

class DataModel{
    static var games:[Games] = [Games(imageName: "Designer-4"),Games(imageName: "Designer-5"),Games(imageName: "Designer-6")]
    static var sessions:[Sessions] = [Sessions(imageName: "Designer-4"),Sessions(imageName: "Designer-4"),Sessions(imageName: "Designer-4")]
    static var worksheets:[Worksheets] = [Worksheets(imageName: "Designer-4"),Worksheets(imageName: "Designer-4"),Worksheets(imageName: "Designer-4")]
    static var sectionHeader:[String] = ["Games","Sessions","Worksheets"]
}
