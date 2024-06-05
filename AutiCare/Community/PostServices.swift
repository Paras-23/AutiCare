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
    
    static func uploadPost(image: UIImage, caption: String, completion: @escaping (Bool) -> Void) {
        guard let userID = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        let postID = UUID().uuidString
        let storageRef = Storage.storage().reference().child("posts").child(userID).child("\(postID).jpg")
        guard let imageData = image.jpegData(compressionQuality: 0.75) else {
            completion(false)
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        storageRef.putData(imageData, metadata: metadata) { result in
            switch result {
            case .success(let metadata):
                storageRef.downloadURL { result in
                    switch result {
                    case .success(let url):
                        let imageURL = url.absoluteString
                        
                        let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timeStamp: Date().timeIntervalSince1970)
                        
                        let postRef = Database.database().reference().child("posts").child(userID).child(postID)
                        postRef.setValue(post.toDictionary()) { (error, ref) in
                            if let error = error {
                                print("Error saving post: \(error.localizedDescription)")
                                completion(false)
                                return
                            }
                            completion(true)
                        }
                    case .failure(let error):
                        print("Error getting download URL: \(error.localizedDescription)")
                        completion(false)
                    }
                }
            case .failure(let error):
                print("Error uploading image: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
    

    static func fetchPosts(forUserID userID: String, completion: @escaping ([Post]) -> Void) {
        let postsRef = Database.database().reference().child("posts").child(userID)
        postsRef.observeSingleEvent(of: .value) { (snapshot, _) in
            var posts = [Post]()

            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                   let dict = childSnapshot.value as? [String: Any],
                   let postID = dict["postID"] as? String,
                   let userID = dict["userID"] as? String,
                   let imageURL = dict["imageURL"] as? String,
                   let caption = dict["caption"] as? String,
                   let timestamp = dict["timestamp"] as? Double {
                    
                    let post = Post(postID: postID, userID: userID, caption: caption, imageURL: imageURL, timeStamp: timestamp)
                    posts.append(post)
                }
            }

            completion(posts)
        }
    }
}

