//
//  ThirdViewController.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class ThirdViewController: UIViewController {

    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var surnameInput: UITextField!
    @IBOutlet weak var countryInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    @IBOutlet weak var phoneInput: UITextField!
    
    enum ControllerMode {
        case create
        case edit(Editable)
    }
    var mode: ControllerMode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupControllerMode()
    }
    
    private func setupControllerMode() {
        guard let mode else { return }
        switch mode {
        case .create:
            title = "Создать контакт"
        case .edit(let editable):
            title = "Изменить контакт"

            guard let user = Auth.auth().currentUser,
                  let contactId = editable.id
            else { return }
            Environment.ref.child("users/\(user.uid)/contacts/\(contactId)").observeSingleEvent(of: .value) { [weak self] snapshot in
                guard let contactValue = snapshot.value as? [String: Any],
                      let contactForEdit = try? Contact(key: contactId, dict: contactValue)
                else { return }
                
                self?.nameInput.text = contactForEdit.name
                self?.surnameInput.text = contactForEdit.surname
                self?.countryInput.text = contactForEdit.country
                self?.cityInput.text = contactForEdit.city
                self?.phoneInput.text = contactForEdit.phone
            }
        }
    }
    
    @IBAction func deketeAction(_ sender: Any) {
        guard let mode else { return }
        switch mode {
        case .create:
            break
        case .edit(let editable):
            
            guard let user = Auth.auth().currentUser,
                  let contactId = editable.id
            else { return }
            Environment.ref.child("users/\(user.uid)/contacts/\(contactId)").removeValue()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        guard let name = nameInput.text,
              let phone = phoneInput.text,
              let user = Auth.auth().currentUser
        else { return }
        
        let contact = Contact(
            id: nil,
            name: name,
            surname: surnameInput.text,
            country: countryInput.text,
            city: cityInput.text,
            phone: phone)
        
        guard let mode else { return }
        switch mode {
        case .create:
            Environment.ref.child("users/\(user.uid)/contacts").childByAutoId().setValue(contact.asDict)
        case .edit(let editable):
            guard let id = editable.id else { return }
            Environment.ref.child("users/\(user.uid)/contacts/\(id)").updateChildValues(contact.asDict)
        }
    }
}
