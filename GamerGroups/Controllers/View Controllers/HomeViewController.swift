//
//  HomeViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/11/23.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    //MARK: - Properties
    var userUid: String = ""
    var user: User?
    var featuredGames: [GameData]?
    var searchedGame: String?
    var gameSearchResults: [GameData]?
    let searchVC = UISearchController(searchResultsController: nil)
    var selectedGame: GameData?
    
    //MARK: - Outlets
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var featuredGamesCollectionView: UICollectionView!
    @IBOutlet weak var displayGamesTableView: UITableView!
    @IBOutlet weak var findPlayersSearchBar: UISearchBar!
    @IBOutlet weak var searchResultsCollectionView: UICollectionView!
    
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        featuredGamesCollectionView.delegate = self
        featuredGamesCollectionView.dataSource = self
        searchResultsCollectionView.delegate = self
        searchResultsCollectionView.dataSource = self
        getUser()
        getPopularGames()
        createSearchBar()
    }
    
    //MARK: - Actions
    @IBAction func updateProfileButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toProfileVC", sender: sender)
    }
    
    //MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredGamesCollectionView {
            return featuredGames?.count ?? 0
        } else if collectionView == searchResultsCollectionView && gameSearchResults != nil{
            return gameSearchResults?.count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredGamesCollectionView {
            guard let cell = featuredGamesCollectionView.dequeueReusableCell(withReuseIdentifier: "featuredGamesCell", for: indexPath) as? FeaturedGamesCollectionViewCell else { return UICollectionViewCell() }
            
            let game = featuredGames?[indexPath.row]
            
            cell.updateView(game: game)
            
            return cell
        } else {
            guard let cell = searchResultsCollectionView.dequeueReusableCell(withReuseIdentifier: "searchResultsCell", for: indexPath) as? SearchResultsCollectionViewCell else { return UICollectionViewCell() }
                    
            let game = gameSearchResults?[indexPath.row]
            cell.updateView(game: game)
                    
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredGamesCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? FeaturedGamesCollectionViewCell else { return }
            self.selectedGame = cell.game
            performSegue(withIdentifier: "toGameVC", sender: cell)
        }
        
        if collectionView == searchResultsCollectionView {
            guard let cell = collectionView.cellForItem(at: indexPath) as? SearchResultsCollectionViewCell else { return }
            self.selectedGame = cell.game
            performSegue(withIdentifier: "toGameVC", sender: cell)
        }
    }
    
    //MARK: - Helpler Methods
    
    func getUser() {
        UserController.shared.fetchUser() { result in
            switch result {
            case .success(let users):
                for user in users {
                    if user.uid == self.userUid {
                        self.usernameLabel.text = user.name
                        self.user = user
                        return
                    }
                }
                
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }
    
    func getPopularGames() {
        GamesController.shared.getPopularGames { result in
            switch result {
            case .success(let games):
                var gameArray: [GameData] = []
                for game in games {
                    if game.name != "Just Chatting" {
                        gameArray.append(game)
                    }
                }
                self.featuredGames = gameArray
                DispatchQueue.main.async {
                    self.featuredGamesCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }
    
    func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchedGame = searchBar.text
        guard let name = searchedGame else { return }
        GamesController.shared.getSearchedGame(name: name) { result in
            switch result {
            case .success(let game):
                self.gameSearchResults = game
                print(game)
                DispatchQueue.main.async {
                    self.searchResultsCollectionView.reloadData()
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProfileVC" {
            guard let destination = segue.destination as? ProfileViewController else { return }
            
//            destination.modalPresentationStyle = .fullScreen
            destination.user = user
            destination.userUID = userUid
            
            if let tags = user?.tags {
                destination.genres = tags
            }
        }
        
        if segue.identifier == "toGameVC" {
            guard let destination = segue.destination as? GameViewController else { return }
            
            destination.game = self.selectedGame
            destination.user = self.user
  
        }
    }
    
}//End Of Class
