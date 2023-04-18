//
//  ViewPlayersiewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/16/23.
//

import UIKit

class ViewPlayersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    //MARK: - Properties
    var user: User?
    
    //MARK: - Outlets
    
    @IBOutlet weak var aboutUserLabel: UILabel!
    @IBOutlet weak var userInterestsLabel: UILabel!
    @IBOutlet weak var tagsTableView: UITableView!
    @IBOutlet weak var aboutUserTextField: UITextView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var usersGamesLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsTableView.dataSource = self
        tagsTableView.delegate = self
        gamesCollectionView.dataSource = self
        gamesCollectionView.delegate = self
        setupView()
    }
    
    //MARK: - Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user?.tags.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedTagsCell", for: indexPath)
        
        cell.textLabel?.text = user?.tags[indexPath.row]
        
        return cell
    }
    
    //MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewGamesCell", for: indexPath) as? ViewPlayersGamesCollectionViewCell else { return UICollectionViewCell() }
        
        guard let user = user,
              let game = user.games?[indexPath.row]
        else { return cell }
        
        cell.updateView(name: game)
        
        return cell
    }
    
    //MARK: - Methods
    
    func setupView() {
        guard let user = user else { return }
        usernameLabel.text = user.name
        aboutUserLabel.text = "About \(user.name)"
        userInterestsLabel.text = "\(user.name)'s Interests:"
        aboutUserTextField.text = user.bio
        usersGamesLabel.text = "\(user.name) Plays:"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}//End Of Class
