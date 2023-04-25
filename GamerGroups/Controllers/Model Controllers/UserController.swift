//
//  UserController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import Foundation
import FirebaseFirestore

class UserController {
    
    //Shared Instance
    static let shared = UserController()
    
    //MARK: - Properties
    var ref: DocumentReference? = nil

    //MARK: - CRUD
    
    func createNewUser(username: String, uid: String, completion: @escaping (Result<User, UserError>) -> Void) {
        
        AppDelegate.db.collection("users").document(uid).setData([
            "name" : username,
            "bio" : "",
            "tags" : [],
            "uid" : uid,
            "games" : []
        ]) { error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                return (completion(.failure(.failedToCreateUser)) )
            } else {
                let user = User(name: username, uid: uid)
                return (completion(.success(user)))
            }
        }
    }
    
    func fetchUser(completion: @escaping (Result<[User], UserError>) -> Void) {
        AppDelegate.db.collection("users").getDocuments { snapshot, error in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
            
            guard let snapshot = snapshot else { return completion(.failure(.unableToFetchUsers)) }
            
            let usersArray = snapshot.documents.map { document in
                
                User(name: document["name"] as? String ?? "",
                     bio: document["bio"] as? String ?? "",
                     tags: document["tags"] as? [String] ?? [],
                     uid: document["uid"] as? String ?? "",
                     games: document["games"] as? [String] ?? []
                )
            }

            return completion(.success(usersArray))
        }
    }
    
    func updateUser(user: User) {
        
        AppDelegate.db.collection("users").document(user.uid).setData([
            "name" : user.name,
            "bio" : user.bio ?? "",
            "tags" : user.tags,
            "uid" : user.uid,
            "games" : user.games
        ])
    }
    
    func deleteUser(uid: String) {
        AppDelegate.db.collection("users").document(uid).delete() { error in
            if let error = error {
                print("Error removing user: \(error)")
            } else {
                print("User succesfully deleted")
            }
        }
    }
    
}//End Of Class
