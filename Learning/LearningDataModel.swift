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

var worksheets : [Worksheet] = [Worksheet(titleImage: "Designer-10", worksheetName: "Select Multiple Objects", worksheetImage: "Workbook-0"), Worksheet(titleImage: "Designer-5", worksheetName: "Uppercase Alphabets", worksheetImage: "Workbook-1"), Worksheet(titleImage: "Designer-9", worksheetName: "Circle the Items", worksheetImage: "Workbook-2")]

var sectionHeader:[String] = ["Games","Sessions","Worksheets"]

var gamesInstructions:[String:Any] = [
    "MemoryCards": """
    
    
    Instructions

1. A grid of face-down cards is displayed on the screen.

2. The game automatically begins once the grid is displayed.

3. Tap or click on any two cards to reveal their faces.

4. Try to remember the positions of the cards as you flip them.

5. Match two cards with identical faces to make a pair.

6. Use your memory to recall the positions of previously flipped cards.

7. Strategize to uncover matching pairs efficiently.

8. Take turns flipping pairs of cards until all matches are found.

9. The game ends when all pairs have been matched.
""",
    "SaveTheDot" : """
Instructions

1. Your Objective is to save the Ball.

2. Naviagte around obstacles such as geometric shapes (Circles, Squares, Triangle, etc) or moving Objects.

3. Colliding with obstacles will result in restarting the level

"""
]

enum ContentType {
    case game, session, worksheet
}


