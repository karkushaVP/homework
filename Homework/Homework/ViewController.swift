//
//  ViewController.swift
//  Homework
//
//  Created by Polya on 13.09.23.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {

    @IBOutlet weak var passwordInput: UITextField!
    @IBOutlet weak var emailInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let userId = Auth.auth().currentUser?.uid {
            print("Залогинен пользователь: \(userId)")
        } else {
            print("Пользователь не залогинен")
        }
    }

    @IBAction func signInAction(_ sender: Any) {
        guard let login = emailInput.text,
              let password = passwordInput.text
        else { return }
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] result, error in
            guard error == nil,
                  let result
            else {
                print(error!.localizedDescription)
                self?.view.backgroundColor = .red
                return
            }
            
            self?.view.backgroundColor = .green
            self?.navigationController?.pushViewController(ProfileController(), animated: true)
        }
    }
    @IBAction func registrationAction(_ sender: Any) {
        guard let email = emailInput.text,
              let password = passwordInput.text
        else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard error == nil,
                  let result
            else {
                print(error!.localizedDescription)
                self?.view.backgroundColor = .red
                return
            }
            
            self?.view.backgroundColor = .green
        }
    }
}

