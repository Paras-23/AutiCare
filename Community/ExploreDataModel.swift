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
    var profilePictureURL : String?
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
            "profilePictureURL" : profilePictureURL
        ]
    }
}

//enum Category {
//    case none , education , health , sports , creativity , motivation , achievemints
//}
struct Post {
    let postID : String
    var userID : String // User who created the post
    var caption : String
    var imageURL : String
//    let mediaType : mediaType
    var timeStamp : TimeInterval
    var likes : [Likes] = []
    var comments : [Comments] = []
    var userName : String?
    var userImageName : String?
    var category : String = ""
    
    func toDictionary() -> [String: Any] {
       return [
           "postID": postID,
           "userID": userID,
           "caption": caption,
           "imageURL": imageURL,
           "timeStamp": timeStamp,
           "category" : category
       ]
    }
    init(postID: String, userID: String, caption: String, imageURL: String, timeStamp : TimeInterval ,userName : String, userImageName : String , category : String) {
            self.postID = postID
            self.userID = userID
            self.caption = caption
            self.imageURL = imageURL
            self.timeStamp = timeStamp
            self.userName = userName
            self.userImageName = userImageName
            self.category = category
        }
    
    
    init(postID: String, userID: String, caption: String, imageURL: String, timeStamp: TimeInterval, category : String) {
        self.postID = postID
        self.userID = userID
        self.caption = caption
        self.imageURL = imageURL
        self.timeStamp = timeStamp
        self.category = category
    }
    
    init(dictionary: [String: Any]) {
        self.postID = dictionary["postID"] as! String
        self.userID = dictionary["userID"] as! String
        self.caption = dictionary["caption"] as! String
        self.imageURL = dictionary["imageURL"] as! String
        self.timeStamp = dictionary["timeStamp"] as! TimeInterval
        self.caption = dictionary["category"] as! String
    }
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

