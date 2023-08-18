//
//  CreateAccountViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import UIKit

class CreateAccountViewController: UIViewController {

    //MARK: - Outlets
    var user: User?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let username = usernameTextField.text,
              !email.isEmpty,
              !password.isEmpty,
              !username.isEmpty
        else { return }
        
        let child = SpinnerViewController()
        
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
        
        self.createAccount(email: email, password: password, username: username, sender: sender)

    }
    
    //MARK: - Helper Methods
    func presentHomeVC() {
        let main = UIStoryboard(name: "Main", bundle: nil)
        let homeViewVC = main.instantiateViewController(withIdentifier: "homeViewController")
        homeViewVC.modalPresentationStyle = .fullScreen
        self.present(homeViewVC, animated: true)
    }
    
    func createAccount(email: String, password: String, username: String, sender: Any) {
        AuthController.shared.createAccount(email: email, password: password, username: username) { result in
            switch result {
            case .success(let user):
                self.user = user
                self.performSegue(withIdentifier: "toHomeVC", sender: sender)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n--\n \(error)")
                let alert = UIAlertController(title: "Failed To Create Account", message: "Ensure you entered a username, valid email, and the password is 6 characters or more.", preferredStyle: .alert)
                
                let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
                
                alert.addAction(dismissAction)
                self.present(alert, animated: true)
            }
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeVC" {
            guard let destination = segue.destination as? HomeViewController else { return }
            
            guard let userID = user?.uid else { return }
            
            destination.modalPresentationStyle = .fullScreen
            destination.userUid = userID
        }
    }

}//End of Class
