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


    var games:[Games] = [Games(imageName: "MemoryCards",gameName: "Memory Cards"),Games(imageName: "WhoISFlying",gameName: "Who's Flying"),Games(imageName: "defendTheBall",gameName: "Defend The Ball"),Games(imageName: "MatchTheShapes", gameName: "Match The Shapes")]

    var sessions:[Sessions] = [Sessions(imageName: "howToPlayWithFriends",sessionName: "Playing With Friends"),Sessions(imageName: "howToTalkToFriends", sessionName: "Talking With Friends"),Sessions(imageName: "howToBehaveWithGuests", sessionName: "How To Behave With Guests")]

    var worksheets:[Worksheets] = [Worksheets(imageName: "Designer-10", worksheetName: ""),Worksheets(imageName: "Designer-5", worksheetName: ""),Worksheets(imageName: "Designer-8", worksheetName: "")]
    
    var sectionHeader:[String] = ["Games","Sessions","Worksheets"]


