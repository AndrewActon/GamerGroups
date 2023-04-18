//
//  AuthError.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/12/23.
//

import Foundation

enum AuthError: LocalizedError {
    
    case failedToSignIn
    case failedToCreateAccount
    
    var errorDescription: String? {
        switch self {
        case .failedToSignIn:
            return "Failed to Sign In"
        case .failedToCreateAccount:
            return "Failed to create account"
        }
    }
}
