//
//  ExploreDataModel.swift
//  AutiCare
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation
import UIKit
import FirebaseDatabaseInternal

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
            "profilePicture" : profilePicture
        ]
    }
}

struct Post {
    let postID : String?
    var userID : String? // User who created the post
    var caption : String
    var imageURL : String
//    let mediaType : mediaType
    var timestamp : TimeInterval
    var likes : [Likes] = []
    var comments : [Comments] = []
    var userImageName : String?
    var userName : String?
    
    func toDictionary() -> [String: Any] {
       return [
           "postID": postID,
           "userID": userID,
           "caption": caption,
           "imageURL": imageURL,
           "timeStamp": timestamp
       ]
    }
    init(postID: String, userID: String, caption: String, imageURL: String, timestamp: TimeInterval,userName : String, userImageName : String) {
            self.postID = postID
            self.userID = userID
            self.caption = caption
            self.imageURL = imageURL
            self.timestamp = timestamp
            self.userName = userName
            self.userImageName = userImageName
        }
    
    
    init(postID: String, userID: String, caption: String, imageURL: String, timestamp: TimeInterval) {
            self.postID = postID
            self.userID = userID
            self.caption = caption
            self.imageURL = imageURL
            self.timestamp = timestamp
        }
    
    init?(dictionary: [String: Any]) {
            guard let postID = dictionary["postID"] as? String,
                  let userID = dictionary["userID"] as? String,
                  let caption = dictionary["caption"] as? String,
                  let imageURL = dictionary["imageURL"] as? String,
                  let timestamp = dictionary["timeStamp"] as? Double else {
                print("Failed to parse post: \(dictionary)")
                return nil
            }
            
            self.postID = postID
            self.userID = userID
            self.caption = caption
            self.imageURL = imageURL
            self.timestamp = timestamp
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

