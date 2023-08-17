//
//  FeaturedGamesCollectionViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import UIKit

class FeaturedGamesCollectionViewCell: UICollectionViewCell {
    
    var game: GameData?
    
    //MARK: - Outlets
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    
    func updateView(game: GameData?) {
        guard let game = game else { return }
        self.game = game
        gameLabel.text = game.name

        let id = game.id
        let imageURL = GamesController.shared.imageURLFormatter120x120(id: id)
        
        gameImage.load(url: imageURL)

    }
    
}
