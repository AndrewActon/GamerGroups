//
//  tagSelectionTableViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/9/23.
//

import UIKit

protocol TagSelectionDelegate: AnyObject {
    func displaySelectedTags(genre: [Genre])
}

class TagSelectionTableViewController: UITableViewController, GenreSelectionDelegate {

    //MARK: - Properties
    var genres: [Genre] = []
    weak var delegate: TagSelectionDelegate?
    var selectedGenres: [Genre] = []
    
    //MARK: - Outlets
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGenres()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genres.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as? TagSelectionTableViewCell else { return UITableViewCell() }
        
        cell.titleLabel.text = genres[indexPath.row].id
        cell.delegate = self
        cell.genre = genres[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

    //MARK: - Actions
    
    @IBAction func addGenresButtonTapped(_ sender: Any) {
        delegate?.displaySelectedTags(genre: selectedGenres)
        self.dismiss(animated: true)
    }
    
    
    //MARK: - Methods
    
    func fetchGenres() {
        TagController.shared.fetchGenres { result in

            DispatchQueue.main.async {
                switch result {
                case .success(let genres):
                    self.genres = genres
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                }
            }
        }
    }
    
    func didSelectTag(genre: Genre) {
        selectedGenres.append(genre)
    }
    
    

}
