//
//  ExploreDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation
import UIKit

struct User {
    let UserID : UUID
    var firstName : String
    var lastName : String
    let userName : String
    var emailAddress : String
    var password : String
    var profilePicture : String?
    var location : String?
    var gender : String
    var age : Int
    var bio : String?
}

struct Posts {
    let postID : UUID
    let userID : UUID // User who created the post
    let caption : String
    let media : UIImage
//    let mediaType : mediaType
    let timeStamp : Date
    let likes : [Likes]
    let comments : [Comments]
}

struct Comments {
    let commentID : UUID
    let postID : UUID
    let userID : UUID
    let content : String
    let timeStamp : Date
}

struct Likes {
    let likeID : UUID
    let postID : UUID  //Which post is liked
    let userID : UUID  //Which user liked the post
    let timeStamp : Date
}


enum mediaType {
    case jpeg, mp4, png, jpg
}


//blocks.jpg, animal.mp4, image.png
