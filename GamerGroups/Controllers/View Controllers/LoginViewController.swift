//
//  LoginViewController.swift
//  FriendFinder
//
//  Created by Andrew Acton on 4/8/23.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - Properties
    private var userIsLoggedIn: Bool = false
    var userUid: String?
    
    //MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    //MARK: - Actions

    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              !email.isEmpty,
              !password.isEmpty
        else { return }
        
        DispatchQueue.main.async {
            AuthController.shared.signInWithEmail(email: email, password: password) { result in
                switch result {
                case .success(let uid):
                    self.userUid = uid
                    print("Login successful")
                    self.emailTextField.text = ""
                    self.passwordTextField.text = ""
                    self.performSegue(withIdentifier: "toHomeVC", sender: sender)
                case .failure(_):
                    let alert = UIAlertController(title: "Invalid Username or Password", message: nil, preferredStyle: .alert)
                    
                    let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel)
                    
                    alert.addAction(dismissAction)
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toCreateAccount", sender: sender)
    }
    
    //MARK: - Helper Methods

    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toHomeVC" {
            guard let destination = segue.destination as? HomeViewController else { return }
            
            guard let userUid = self.userUid else { return }
            
            destination.modalPresentationStyle = .fullScreen
            destination.userUid = userUid
        }
    }
    
    
}//End Of Class
