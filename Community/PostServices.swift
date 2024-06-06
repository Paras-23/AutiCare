//
//  PostServices.swift
//  AutiCare
//
//  Created by Batch-1 on 05/06/24.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage


class PostService {
//    static func fetchPosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
//        let postsRef = Database.database().reference().child("posts").child(userID)
//        postsRef.observeSingleEvent(of: .value) { (snapshot, _) in
//            var posts = [Post]()
//            
//            for child in snapshot.children {
//                if let childSnapshot = child as? DataSnapshot,
//                   let dict = childSnapshot.value as? [String: Any],
//                   let post = Post(dictionary: dict) {
//                    posts.append(post)
//                }
//            }
//
//            // Sort the posts by timestamp
//            posts.sort(by: { $0.timestamp > $1.timestamp })
//
//            completion(posts)
//        }
//    }
    static func fetchPosts1(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        print("again inside")
        let postsRef = Database.database().reference().child("user").child(userID).child("posts")
        postsRef.observeSingleEvent(of: .value) { (snapshot, _) in
            var posts = [Post]()

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],
                   let postID = dict["postID"] as? String,
                   let userID = dict["userID"] as? String,
                   let imageURL = dict["imageURL"] as? String,
                   let caption = dict["caption"] as? String,
                   let timestamp = dict["timestamp"] as? TimeInterval {
                    
                    let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timestamp: timestamp)
                    posts.append(post)
                }
            }
            posts.sort(by: { $0.timestamp > $1.timestamp })
            print(posts)
            print("inside 3")
            completion(posts)
            print(posts)
            print("inside 4")
        }
    }

    
 
        static func fetchPosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
            let postsRef = Database.database().reference().child("user").child(userID).child("posts")
            postsRef.observeSingleEvent(of: .value) { snapshot in
                var posts = [Post]()
                
                print("Snapshot exists: \(snapshot.exists())")
                print("Snapshot value: \(snapshot.value ?? "No value")")

                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let dict = childSnapshot.value as? [String: Any] {
                        print("Child Snapshot: \(dict)")
                        if let post = Post(dictionary: dict) {
                            posts.append(post)
                        } else {
                            print("Failed to create Post from dictionary: \(dict)")
                        }
                    }
                }

                // Sort the posts by timestamp
                posts.sort(by: { $0.timestamp > $1.timestamp })
                
                print("Fetched posts: \(posts)")
                print(posts.isEmpty)
                completion(posts)
            }
        }
    


    static func fetchPosts4(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
            print("Making Firebase query for user ID: \(userID)")
            
            // Assuming your Firebase Database structure is something like /posts/userID/
        let postsRef = Database.database().reference().child("user").child(userID).child("posts")
            
            postsRef.observeSingleEvent(of: .value) { snapshot in
                var posts: [Post] = []
                
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let dict = childSnapshot.value as? [String: Any],
                       let postID = dict["postID"] as? String,
                       let userID = dict["userID"] as? String,
                       let caption = dict["caption"] as? String,
                       let imageURL = dict["imageURL"] as? String,
                       let timestamp = dict["timestamp"] as? Double {
                        
                        let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timestamp: timestamp)
                        posts.append(post)
                    }
                }
                
                print("Firebase query completed with posts: \(posts)")
                completion(posts)
            } withCancel: { error in
                print("Firebase query error: \(error.localizedDescription)")
                completion([])
            }
        }
    
    static func fetchPosts5(forUserID userID: String, completion: @escaping ([String]) -> Void) {
            let postsRef = Database.database().reference().child("user").child(userID).child("posts")
            var imageURLs: [String] = []

            postsRef.observeSingleEvent(of: .value) { snapshot in
                for child in snapshot.children {
                    if let childSnapshot = child as? DataSnapshot,
                       let dict = childSnapshot.value as? [String: Any],
                       let imageURL = dict["imageURL"] as? String {
                        imageURLs.append(imageURL)
                    }
                }
                print("Firebase query completed with image URLs: \(imageURLs)")
                completion(imageURLs)
            } withCancel: { error in
                print("Firebase query error: \(error.localizedDescription)")
                completion([])
            }
        
        }




    
//    static func uploadPost(image: UIImage, caption: String, completion: @escaping (Bool) -> Void) {
//        
//        let storage = Storage.storage()
//        let database = Database.database().reference()
//        
//        guard let imageData = image.jpegData(compressionQuality: 0.75), let userID = Auth.auth().currentUser?.uid else {
//            completion(false)
//            return
//        }
//                
//        let postID = UUID().uuidString
//        let storageRef = storage.reference().child("posts").child(userID).child("\(postID).jpg")
//                
//        let metadata = StorageMetadata()
//        metadata.contentType = "image/jpeg"
//        
//        storageRef.putData(imageData, metadata: metadata) { metadata, error in
//            guard metadata != nil else {
//            print("Failed to upload image")
//            completion(false)
//            return
//        }
//                    
//        storageRef.downloadURL { url, error in
//            guard let downloadURL = url else {
//            print("Failed to retrieve download URL")
//            completion(false)
//            return
//        }
//                
//        let imageURL = downloadURL.absoluteString
//        let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timeStamp: Date().timeIntervalSince1970)
//        
//        let postRef = database.child("posts").child(userID).child(postID)
//                postRef.setValue(post.toDictionary()) { error, ref in
//                    if let error = error {
//                        print("Error saving post: \(error.localizedDescription)")
//                        completion(false)
//                        return
//                    }
//                    completion(true)
//                }
//            }
//        }
//    }
    

   
}
