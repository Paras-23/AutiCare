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
        users = [ User(UserID: UUID(), firstName: "David", lastName: "Beckham", userName: "iamdavid", emailAddress: "beckham@gmail.com", password: "miamidream", phone: "", profilePicture: "user_1" ,gender: "male", age: 35),
                  User(UserID: UUID(), firstName: "Khal", lastName: "Drogo", userName: "dothraki", emailAddress: "khaldrogo@gmail.com", password: "12345", phone: "", profilePicture: "user_2" ,gender: "male", age: 32)
                  ,
                  User(UserID: UUID(), firstName: "Emma", lastName: "Watson", userName: "itsemma", emailAddress: "emmawatson@gmail.com", password: "hermoineiam", phone: "", profilePicture: "user_3" ,gender: "female", age: 20)
        ]
        users[0].followers = [users[1], users[2]]
        users[0].following = [users[2], users[1]]
        users[1].followers = [users[0], users[2]]
        users[1].following = [users[2], users[0]]
        users[2].followers = [users[0], users[1]]
        users[2].followers = [users[1], users[0]]
    }
    
    func dummyPosts() {
        posts = [ Post(postID: "1", userID: "1", caption: "Playing with amigos is always a moment worth capturing📸😎", imageURL: "post_1", timestamp: 1, userName: "Aditya Gupta" , userImageName: "user_1"),Post(postID: "2",userID: "2", caption: "When she mocks me with a camera of her own.😓 It's a mother daughter love❤️", imageURL: "post_2", timestamp: 2, userName: "Sourabh kumar" , userImageName: "user_2"),
                  Post(postID: "3",userID: "3", caption: "Painting with hand or hand with painting. It's still a mystery to be solved.🤔", imageURL: "post_3", timestamp: 3, userName: "Harender Singh",userImageName: "user_3")
        ]
    }

    func getPosts() -> [Post] { posts }
    func getUsers() -> [User] {users}
    func fetchOnlinePosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        PostService.fetchPosts(forUserID: userID) { posts in
            completion(posts)
        }
    }
}


//3 Users
//Paras - 100 ---- 3 Posts ---- 1 - 200, 2 - 201, 3 - 202
//Madhav - 101 ---- 2 Posts
//Sudhanshu - 102 ---- 3 Posts

