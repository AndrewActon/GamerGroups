//
//  UserError.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/12/23.
//

import Foundation

enum UserError: LocalizedError {
    
    case unableToFetchUsers
    case failedToCreateUser
    
    var errorDescription: String? {
        switch self {
        case .unableToFetchUsers:
            return "Unable to retrive users from database"
        case .failedToCreateUser:
            return "Failed to create user"
        }
    }
}//End Of Enum
