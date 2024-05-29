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
var games:[Games] = [Games(imageName: "Designer-20"),Games(imageName: "Designer-12"),Games(imageName: "Designer-15")]
class DataModel{
    static var games:[Games] = [Games(imageName: "Designer-20"),Games(imageName: "Designer-12"),Games(imageName: "Designer-15")]
    static var sessions:[Sessions] = [Sessions(imageName: "Designer-2"),Sessions(imageName: "Designer-4"),Sessions(imageName: "Designer-14")]
    static var worksheets:[Worksheets] = [Worksheets(imageName: "Designer-10"),Worksheets(imageName: "Designer-5"),Worksheets(imageName: "Designer-8")]
    static var sectionHeader:[String] = ["Games","Sessions","Worksheets"]
}
