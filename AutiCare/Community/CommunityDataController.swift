//
//  CommunityDataController.swift
//  AutiCare
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation

class CommunityDataController {
    
    var posts : [Post] = []
    var users : [User] = []
    
    static let shared = CommunityDataController()
    
    private init() {
        dummyUsers()
        dummyPosts()
    }
    
    func dummyUsers() {
        users = [ User(UserID: UUID(), firstName: "David", lastName: "Beckham", userName: "iamdavid", emailAddress: "beckham@gmail.com", password: "miamidream", gender: .male, age: 35),
                  User(UserID: UUID(), firstName: "Khal", lastName: "Drogo", userName: "dothraki", emailAddress: "khaldrogo@gmail.com", password: "12345", gender: .male, age: 32),
                  User(UserID: UUID(), firstName: "Emma", lastName: "Watson", userName: "itsemma", emailAddress: "emmawatson@gmail.com", password: "hermoineiam", gender: .female, age: 20)
        ]
    }
    
    func dummyPosts() {
        posts = [ Post(postID: UUID(), userID: users[0].UserID, caption: "Playing with amigos is always a moment worth capturing📸😎", imageName: "post_1", userImageName: "user_1", userName: "David Beckham"),
                  Post(postID: UUID(), userID: users[1].UserID, caption: "When she mocks me with a camera of her own.😓 It's a mother daughter love❤️", imageName: "post_2", userImageName: "user_2", userName: "Khal Drogo"),
                  Post(postID: UUID(), userID: users[2].UserID, caption: "Painting with hand or hand with painting. It's still a mystery to be solved.🤔", imageName: "post_3", userImageName: "user_3", userName: "Emma Watson")
        ]
    }
    
    func getPosts() -> [Post] { posts }
    func onlinePosts() -> [Post]? {nil}
}


//3 Users
//Paras - 100 ---- 3 Posts ---- 1 - 200, 2 - 201, 3 - 202
//Madhav - 101 ---- 2 Posts
//Sudhanshu - 102 ---- 3 Posts

