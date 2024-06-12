//
//  PostServices.swift
//  AutiCare
//
//  Created by Batch-1 on 05/06/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class PostService {

    static func uploadPost(image: UIImage, caption: String, category: String , userID: String, completion: @escaping (Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(false)
            return
        }
        
        let postID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(userID).child(postID)
        
        storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                print("Failed to upload image: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            storageRef.downloadURL { url, error in
                guard let imageURL = url?.absoluteString else {
                    completion(false)
                    return
                }
                
                let timeStamp = Date().timeIntervalSince1970
                let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timeStamp: timeStamp, category: category)
                
                let postsRef = Database.database().reference().child("posts").child(postID)
                let userPostsRef = Database.database().reference().child("users").child(userID).child("posts").child(postID)
                
                postsRef.setValue(post.toDictionary()) { error, _ in
                    if let error = error {
                        print("Failed to upload post data: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    
                    userPostsRef.setValue(true) { error, _ in
                        if let error = error {
                            completion(false)
                            return
                        }
                        if category == "" {
                            completion(true)
                            return
                        }
                        let categoryWisePostsRef = Database.database().reference().child("categories").child(category).child(postID)
                        categoryWisePostsRef.setValue(true) { error , _ in
                            if let error = error {
                                completion(false)
                                return
                            }
                            completion(true)
                        }
                    }
                }
            }
        }
    }

    static func fetchCurrentUserPosts1(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        let postsRef = Database.database().reference().child("users").child(userID).child("posts")
        postsRef.observeSingleEvent(of: .value ) { snapshot in
            guard let postIDs = snapshot.value as? [String: Bool] else {
                completion([])
                return
            }
            
            var userPosts: [Post] = []
            let dispatchGroup = DispatchGroup()
            
            for postID in postIDs.keys {
                dispatchGroup.enter()
                let postRef = Database.database().reference().child("posts").child(postID)
                        
                postRef.observeSingleEvent(of: .value) { postSnapshot in
                    if let postDict = postSnapshot.value as? [String: Any] {
                        userPosts.append(Post(dictionary: postDict))
                    }
                    else {
                        print("Failed to fetch Post of PostID : \(postID)")
                    }
                    dispatchGroup.leave()
                }
                
                dispatchGroup.notify(queue: .main) {
                    userPosts.sort(by: { $0.timeStamp > $1.timeStamp }) // Sort posts by timestamp
                    completion(userPosts)
                }
            }
        }
    }
    
    static func fetchCategoryWisePosts(category : String, completion: @escaping ([Post]) -> Void) {
        let categoryRef = Database.database().reference().child("categories").child(category)
        categoryRef.observeSingleEvent(of: .value ) { snapshot in
            guard let postIDs = snapshot.value as? [String: Bool] else {
                completion([])
                return
            }
            
            var userPosts: [Post] = []
            let dispatchGroup = DispatchGroup()
            
            for postID in postIDs.keys {
                dispatchGroup.enter()
                let postRef = Database.database().reference().child("posts").child(postID)
                        
                postRef.observeSingleEvent(of: .value) { postSnapshot in
                    if let postDict = postSnapshot.value as? [String: Any] {
                        userPosts.append(Post(dictionary: postDict))
                    }
                    else {
                        print("Failed to fetch Post of PostID : \(postID)")
                    }
                    dispatchGroup.leave()
                }
                dispatchGroup.notify(queue: .main) {
                    userPosts.sort(by: { $0.timeStamp > $1.timeStamp }) // Sort posts by timestamp
                    completion(userPosts)
                }
            }
        }
    }
    
    static func fetchAllPosts(completion: @escaping ([Post]) -> Void) {
        let postsRef = Database.database().reference().child("posts")
        postsRef.observeSingleEvent(of: .value) { snapshot in
            var posts = [Post]()
            
            for postSnapshot in snapshot.children {
                if let postSnapshot = postSnapshot as? DataSnapshot,
                   let postDict = postSnapshot.value as? [String: Any]{
                    posts.append(Post(dictionary: postDict))
                } else {
                    print("Failed to create Post from snapshot: \(postSnapshot)")
                }
            }
            // Sort the posts by timestamp
            posts.sort(by: { $0.timeStamp > $1.timeStamp })
            completion(posts)
        }
    }
    
    static func fetchAllUsers(completion : @escaping ([String]) -> Void){
        let usersRef = Database.database().reference().child("users")
        usersRef.observeSingleEvent(of: .value) { snapshot in
            var users : [String] = []
            
            for userId in snapshot.children {
                let id = userId as! DataSnapshot
                users.append(id.key)
            }
            
            completion(users)
        }
    }
    
    static func fetchCurrentUserFollowingPosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        let postsRef = Database.database().reference().child("users").child(userID).child("following")
        postsRef.observeSingleEvent(of: .value) { snapshot in
            guard let userIds = snapshot.value as? [String: Bool] else {
                print("No following users found for userID: \(userID)")
                completion([])
                return
            }

            var userPosts: [Post] = []
            let dispatchGroup = DispatchGroup()

            for followedUserID in userIds.keys {
                dispatchGroup.enter()
                fetchCurrentUserPosts(forUserID: followedUserID) { posts in
                    userPosts.append(contentsOf: posts)
                    print(userPosts.count)
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                print("Fetched \(userPosts.count) posts from followed users.")
                userPosts.sort(by: { $0.timeStamp > $1.timeStamp }) // Sort posts by timestamp
                completion(userPosts)
            }
        } withCancel: { error in
            print("Failed to fetch following users for userID: \(userID) with error: \(error.localizedDescription)")
            completion([])
        }
    }

    static func fetchCurrentUserPosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        let postsRef = Database.database().reference().child("users").child(userID).child("posts")
        postsRef.observeSingleEvent(of: .value) { snapshot in
            guard let postIDs = snapshot.value as? [String: Bool] else {
                print("No posts found for userID: \(userID)")
                completion([])
                return
            }

            var userPosts: [Post] = []
            let dispatchGroup = DispatchGroup()

            for postID in postIDs.keys {
                dispatchGroup.enter()
                let postRef = Database.database().reference().child("posts").child(postID)

                postRef.observeSingleEvent(of: .value) { postSnapshot in
                    if let postDict = postSnapshot.value as? [String: Any] {
                        userPosts.append(Post(dictionary: postDict))
                    } else {
                        print("Failed to fetch Post of PostID: \(postID)")
                    }
                    dispatchGroup.leave()
                } withCancel: { error in
                    print("Failed to fetch post details for postID: \(postID) with error: \(error.localizedDescription)")
                    dispatchGroup.leave()
                }
            }

            dispatchGroup.notify(queue: .main) {
                print("Fetched \(userPosts.count) posts for userID: \(userID)")
                userPosts.sort(by: { $0.timeStamp > $1.timeStamp }) // Sort posts by timestamp
                completion(userPosts)
            }
        } withCancel: { error in
            print("Failed to fetch posts for userID: \(userID) with error: \(error.localizedDescription)")
            completion([])
        }
    }

}
