//
//  TagSelectionTableViewCell.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/9/23.
//

import UIKit

protocol GenreSelectionDelegate {
    func didSelectTag(genre: Genre)
}

class TagSelectionTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var delegate: GenreSelectionDelegate?
    var genre: Genre?

    //MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreSelectButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    //MARK: - Actions
    
    @IBAction func genreSelectButtonTapped(_ sender: Any) {
        toggleButton()
        guard let genre = genre else { return }
        delegate?.didSelectTag(genre: genre)
    }
    
    //MARK: - Methods
    
    func toggleButton() {
        genreSelectButton.isSelected = !genreSelectButton.isSelected
    }
    
    func setupView() {
        genreSelectButton.setImage(UIImage(systemName: "circle"), for: .normal)
        genreSelectButton.setImage(UIImage(systemName: "circle.fill"), for: .selected)
    }
    
}
