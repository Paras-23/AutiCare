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
    var fullName : String {firstName + " " + lastName}
    let userName : String
    var emailAddress : String
    var password : String
    var phone : String
    var profilePicture : String?
    var coverPicture : String?
    var location : String?
    var gender : String
    var age : Int?
    var bio : String?
    var following : [User]?
    var followers : [User]?
    var posts : [Post]?
    
    func toDictionary() -> [String: Any] {
        return [
            "UserID": UserID.uuidString,
            "firstName": firstName,
            "lastName": lastName,
            "fullName" : fullName,
            "userName": userName,
            "emailAddress": emailAddress,
            "password": password,
            "phone": phone,
            "gender": gender,
            "profilePicture" : profilePicture,
            "coverPicture" : coverPicture,
            "location" : location,
            "age" : age,
            "bio" : bio,
            "following" : following,
            "followers" : followers,
            "posts" : posts
            
        ]
    }
}

struct Post {
    let postID : UUID
    let userID : UUID // User who created the post
    let caption : String
    let imageName : String
//    let mediaType : mediaType
    let timeStamp : Date = Date.now
    let likes : [Likes] = []
    let comments : [Comments] = []
    let userImageName : String
    let userName : String
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

