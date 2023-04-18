//
//  AuthController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import Foundation
import Firebase

class AuthController {
    
    //Shared Instance
    static let shared = AuthController()
    
    //MARK: - Methods
    
    func signInWithEmail(email: String, password: String, completion: @escaping (Result<String, AuthError>) -> Void) {

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                return completion(.failure(.failedToSignIn))
            }
            
            guard let authResult = result else { return completion(.failure(.failedToSignIn)) }
            print("Authentication succesfull. User: \(authResult.user.uid)")
            return completion(.success(authResult.user.uid))
        }
    }
    
    func createAccount(email: String, password: String, username: String, completion: @escaping (Result<User, AuthError>) -> Void) {

        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if error != nil {
                return completion(.failure(.failedToCreateAccount))
            }
            
            guard let authResult = result else { return completion(.failure(.failedToCreateAccount)) }
            UserController.shared.createNewUser(username: username, uid: authResult.user.uid) { result in
                switch result {
                case .success(let user):
                    return completion(.success(user))
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
}//End of Class
