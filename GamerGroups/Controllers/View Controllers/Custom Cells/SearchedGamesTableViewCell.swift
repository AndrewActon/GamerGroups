//
//  SearchedGamesTableViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import UIKit

class SearchedGamesTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Methods
    
    func updateView(game: GameData?) {
        guard let game = game else { return }
        nameLabel.text = game.name
        
        let id = game.id
        let imageURL = GamesController.shared.imageURLFormatter(id: id)
        
        gameImage.load(url: imageURL)
    }
    
}
