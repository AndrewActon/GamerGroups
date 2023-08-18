//
//  PlayerGamesCollectionViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/16/23.
//

import UIKit

class PlayerGamesCollectionViewCell: UICollectionViewCell {
    
    
    //MARK: - Outlets
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
 
    func updateView(name: String) {
        GamesController.shared.getSearchedGame(name: name) { result in
            switch result {
            case .success(let games):
                let game = games[0]
                let id = game.id
                let imageURL = GamesController.shared.imageURLFormatter80x80(id: id)
                DispatchQueue.main.async {
                    self.gameLabel.text = game.name
                    self.gameImage.load(url: imageURL)
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
        
        
        
    }
    
    
}
