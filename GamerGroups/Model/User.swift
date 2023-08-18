//
//  User.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import Foundation
import UIKit

class User {
    var name: String
    var bio: String?
    var tags: [String]
    var uid: String
    var games: [String]?
    
    init(name: String, bio: String? = nil, tags: [String] = [], uid: String, games: [String] = []) {
        self.name = name
        self.bio = bio
        self.tags = tags
        self.uid = uid
        self.games = games
    }
}
