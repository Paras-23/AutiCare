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
    var storyboardID : String?
}
struct Sessions{
    var imageName:String
    var sessionName : String
    var watched : Bool?
    var resourceURL : String?
}
struct Worksheet{
    var titleImage:String
    var worksheetName : String
    var worksheetImage : String
    var completed : Bool?
}

struct QuestionOfPictureRepresentingAction {
    let text: String
    let option1: String
    let option2: String
    let correctOption: Int
}

var games : [Games] = [Games(imageName: "MemoryCards",gameName: "Memory Cards", storyboardID: "MemoryCardGame"),Games(imageName: "WhoISFlying",gameName: "Who's Flying", storyboardID: "IdentifyWhosFlyingGame"),Games(imageName: "defendTheBall",gameName: "Defend The Ball", storyboardID: "SaveTheDotGame"),Games(imageName: "MatchTheShapes", gameName: "Match The Shapes", storyboardID: "ColorMatchingGame")]

var sessions : [Sessions] = [Sessions(imageName: "howToPlayWithFriends",sessionName: "Playing With Friends", resourceURL: "playingWithFriends"),Sessions(imageName: "howToTalkToFriends", sessionName: "Talking With Friends", resourceURL: "howToTalkToFriends"),Sessions(imageName: "howToBehaveWithGuests", sessionName: "How To Behave With Guests", resourceURL: "howToBehaveWithGuests")]

var worksheets : [Worksheet] = [Worksheet(titleImage: "Designer-10", worksheetName: "Select Multiple Objects", worksheetImage: "Workbook-0"), Worksheet(titleImage: "Designer-5", worksheetName: "Match Uppercase", worksheetImage: "Workbook-1"), Worksheet(titleImage: "Designer-9", worksheetName: "Uppcase Alphabets", worksheetImage: "Workbook-2")]

var sectionHeader:[String] = ["Games","Sessions","Worksheets"]

enum ContentType {
    case game, session, worksheet
}


