//
//  Tag.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import Foundation

struct Tag: Decodable {
    var genres: [Genre]
}//End Of Struct

struct Genre: Decodable, Equatable {
    var id: String
    
    static func == (lhs: Genre, rhs: Genre) -> Bool {
        return lhs.id == rhs.id
    }
}//End Of Struct
