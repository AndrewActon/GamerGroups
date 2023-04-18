//
//  PlayersCollectionViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import UIKit

class PlayersCollectionViewCell: UICollectionViewCell {
        
    //MARK: - Outlets
    @IBOutlet weak var playerNameLabel: UILabel!
    @IBOutlet weak var playerIconImage: UIImageView!
    
    func updateView(user: User?) {
        guard let user = user else { return }
        playerNameLabel.text = user.name
        playerIconImage.image = UIImage(systemName: "person")
    }
    
}
