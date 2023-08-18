//
//  SearchResultsCollectionViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import UIKit

class SearchResultsCollectionViewCell: UICollectionViewCell {
    
    var game: GameData?
    
    //MARK: - Outlets
    @IBOutlet weak var gameIamge: UIImageView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    func updateView(game: GameData?) {
        guard let game = game else { return }
        gameNameLabel.text = game.name
        gameNameLabel.sizeToFit()
        self.game = game
        
        let id = game.id
        let imageURL = GamesController.shared.imageURLFormatter80x80(id: id)
        
        gameIamge.load(url: imageURL)
        
    }
    
}
