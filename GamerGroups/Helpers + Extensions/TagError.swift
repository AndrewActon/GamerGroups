//
//  TagError.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/9/23.
//

import Foundation

enum TagError: LocalizedError {
    
    case invalidURL
    case noData
    case thrownError(Error)
    case unableToDecode
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The server failed to reach the necessary URL."
        case .noData:
            return "The server responded with no data"
        case .thrownError(let error):
            return "Error in \(#function) : \(error.localizedDescription) \n--\n \(error)"
        case .unableToDecode:
            return "Unable to decode the data"
        }
    }
    
}//End of Enum
