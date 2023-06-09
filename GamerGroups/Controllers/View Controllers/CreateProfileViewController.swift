//
//  CreateProfileViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate, TagSelectionDelegate {

    //MARK: - Properties
    var userUID: String = ""
    var user: User?
    var genres: [String] = []
    
    //MARK: - Outlets
    @IBOutlet weak var bioTextField: UITextView!
    @IBOutlet weak var tagTableView: UITableView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var gamesCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tagTableView.delegate = self
        self.tagTableView.dataSource = self
        self.gamesCollectionView.dataSource = self
        self.gamesCollectionView.delegate = self
        setupViews()
    }
    
    //MARK: - Tableview Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        genres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedTagsCell", for: indexPath)
        
        cell.textLabel?.text = genres[indexPath.row]
        
        return cell
    }
    
    //MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return user?.games?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "gameCell", for: indexPath) as? PlayerGamesCollectionViewCell else { return UICollectionViewCell() }
        
        guard let user = user,
              let game = user.games?[indexPath.row]
        else { return cell }
        
        cell.updateView(name: game)
        
        return cell
    }
    
    //MARK: - Actions
    
    @IBAction func updateProfileButtonTapped(_ sender: Any) {
        guard let user = user else { return }
        
        user.bio = bioTextField.text
        user.tags = genres
        
        UserController.shared.updateUser(user: user)
        
        performSegue(withIdentifier: "toHomeVC", sender: sender)
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure?", message: "This will permanently delete your account.", preferredStyle: .alert)
        
        let deleteAccount = UIAlertAction(title: "Delete Account", style: .destructive) {_ in
            AuthController.shared.deleteAccount()
            UserController.shared.deleteUser(uid: self.userUID)
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAccount)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
        
        
    }
    
    
    @IBAction func addTagsButtonTapped(_ sender: Any) {
        
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: "You are about to logout.", message: "Do you wish to proceed?", preferredStyle: .alert)
        
        let logoutAction = UIAlertAction(title: "Logout", style: .destructive) {_ in
            self.view.window?.rootViewController?.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(logoutAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true)
    }
    
    
    
    //MARK: - Helper Methods
    
    func setupViews() {
        usernameLabel.text = user?.name
        bioTextField.text = user?.bio
    }
    
    func displaySelectedTags(genre: [Genre]) {
        genres = genre.map { $0.id }
        tagTableView.reloadData()
    }

    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTagSelection" {
            guard let destinationNavigationController = segue.destination as? UINavigationController,
                  let destination = destinationNavigationController.topViewController as? TagSelectionTableViewController
            else { return }
                                
                    destination.delegate = self
        }
        
        if segue.identifier == "toHomeVC" {
            guard let destination = segue.destination as? HomeViewController else { return }
            
            destination.modalPresentationStyle = .fullScreen
            destination.user = user
            destination.userUid = userUID
        }
    }


}//End Of Class

