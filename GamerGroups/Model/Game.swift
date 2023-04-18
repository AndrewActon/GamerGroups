//
//  Game.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import Foundation

struct Game: Decodable {
    var data: [GameData]
}

struct GameData: Decodable {
    
    var id: String
    var name: String
    var boxArtURL: String
    var igdbID: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case boxArtURL = "box_art_url"
        case igdbID = "igdb_id"
    }

}
