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
    
    static func fetchAllUsersPosts(completion: @escaping ([Post]) -> Void) {
        let usersRef = Database.database().reference().child("user")
        usersRef.observeSingleEvent(of: .value) { snapshot in
            var posts = [Post]()
            
            print("Snapshot exists: \(snapshot.exists())")
            print("Snapshot value: \(snapshot.value ?? "No value")")
            
            for userSnapshot in snapshot.children {
                if let userSnapshot = userSnapshot as? DataSnapshot{
                   let postsSnapshot = userSnapshot.childSnapshot(forPath: "posts")
                    for postSnapshot in postsSnapshot.children {
                        if let postSnapshot = postSnapshot as? DataSnapshot,
                           let postDict = postSnapshot.value as? [String: Any],
                           let post = Post(dictionary: postDict) {
                            posts.append(post)
                        } else {
                            print("Failed to create Post from snapshot: \(postSnapshot)")
                        }
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
    
    static func uploadPost(image: UIImage, caption: String, userID: String, completion: @escaping (Bool) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(false)
            return
        }
        
        let postID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(userID).child("\(postID).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            storageRef.downloadURL { url, error in
                if let error = error {
                    print("Error getting download URL: \(error.localizedDescription)")
                    completion(false)
                    return
                }
                
                guard let downloadURL = url else {
                    print("Download URL is nil")
                    completion(false)
                    return
                }
                
                let post = Post(postID: postID, userID: userID, caption: caption, imageURL: downloadURL.absoluteString, timestamp: Date().timeIntervalSince1970)
                
                let postRef = Database.database().reference().child("user").child(userID).child("posts").child(postID)
                postRef.setValue(post.toDictionary()) { error, ref in
                    if let error = error {
                        print("Error saving post: \(error.localizedDescription)")
                        completion(false)
                        return
                    }
                    completion(true)
                }
            }
        }
    }
   
}
