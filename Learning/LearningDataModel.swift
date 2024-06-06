//
//  LearningDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation

struct Games{
    var imageName : String
    var gameName : String
    var isCompleted : Bool?
}
struct Sessions{
    var imageName:String
    var sessionName : String
    var watched : Bool?
}
struct Worksheets{
    var imageName:String
    var worksheetName : String
    var completed : Bool?
}

struct QuestionOfPictureRepresentingAction {
    let text: String
    let option1: String
    let option2: String
    let correctOption: Int
}


    var games:[Games] = [Games(imageName: "Designer-20",gameName: "Memory Cards"),Games(imageName: "Designer-12",gameName: "Who's Flying"),Games(imageName: "Designer-15",gameName: "Defend The Ball")]

    var sessions:[Sessions] = [Sessions(imageName: "Designer-2",sessionName: ""),Sessions(imageName: "Designer-4", sessionName: ""),Sessions(imageName: "Designer-14", sessionName: "")]

    var worksheets:[Worksheets] = [Worksheets(imageName: "Designer-10", worksheetName: ""),Worksheets(imageName: "Designer-5", worksheetName: ""),Worksheets(imageName: "Designer-8", worksheetName: "")]
    
    var sectionHeader:[String] = ["Games","Sessions","Worksheets"]


