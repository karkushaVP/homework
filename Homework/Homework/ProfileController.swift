//
//  ProfileController.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ProfileController: UIViewController {
    
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var countryInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let name = nameInput.text,
              let surName = surnameInput.text,
              let country = countryInput.text,
              let city = cityInput.text,
              let phone = phoneInput.text,
              let user = Auth.auth().currentUser
        else { return }
        
        let userData: [String: Any] = [
            "username": name,
            "surname": surName,
            "country": country,
            "city": city,
            "phone": phone
        ]
    }
    
    private func readUserData() {
        guard let user = Auth.auth().currentUser else { return }
    }
}




