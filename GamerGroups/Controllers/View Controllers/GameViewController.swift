//
//  GameViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/15/23.
//

import UIKit

class GameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Properties
    var game: GameData?
    var user: User?
    var users: [User]?
    
    //MARK: - Outlets
    @IBOutlet weak var gameImageView: UIImageView!
    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var playersCollectionView: UICollectionView!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        playersCollectionView.dataSource = self
        playersCollectionView.delegate = self
        setupView()
        fetchUsers()
    }
    
    //Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = playersCollectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as? PlayersCollectionViewCell else { return UICollectionViewCell() }
                 
        if users != nil {
            let user = users?[indexPath.row]
            
            cell.updateView(user: user)
            
            return cell
        }

        cell.playerNameLabel.text = "No users play this game"
        
        return cell
    }
    
    //MARK: - Actions
    @IBAction func addGameButtonTapped(_ sender: Any) {
        guard let user = user,
              let game = game
        else { return }
        
        guard let gameArray = user.games else { return }
        
        if !gameArray.contains(game.name) {
            user.games?.append(game.name)
            self.user = user
            UserController.shared.updateUser(user: user)
        }
    }
    
    //MARK: - Methods
    
    func setupView() {
        //Display game image & title
        guard let game = game else { return }
        
        gameLabel.text = game.name
        
        let id = game.id
        let imageURL = GamesController.shared.imageURLFormatter160x160(id: id)
        
        gameImageView.load(url: imageURL)
    }
    
    func fetchUsers() {
        UserController.shared.fetchUser { result in
            switch result {
            case .success(let users):
                var userArray: [User] = []
                for user in users {
                    guard let games = user.games,
                          let name = self.game?.name
                    else { return }
                    if games.contains(name) && user.name != self.user?.name {
                        userArray.append(user)
                    }
                }
                if userArray.count > 0 {
                    self.users = userArray
                    DispatchQueue.main.async {
                        self.playersCollectionView.reloadData()
                    }
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toViewPlayer" {
            guard let destination = segue.destination as? ViewPlayersViewController,
                  let cell = sender as? PlayersCollectionViewCell,
                  let indexPath = self.playersCollectionView.indexPath(for: cell),
                  let user = self.users?[indexPath.row]
            else { return }
            
            destination.user = user
        }
    }

}
