//
//  SecondViewController.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import UIKit
import FirebaseAuth
import SwiftUI

class SecondViewController: UIViewController {
    private var contacts: [Contact] = []

    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        readContact()
    }
    
    @IBAction func addAction(_ sender: Any) {
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func parseData(_ dict: [String : Any]) {
        contacts.removeAll()
        for (key, value) in dict {
            guard let answer = value as? [String: Any] else { continue }
            guard let new = try? Contact(
                key: key,
                dict: answer
            ) else { continue }
            
            self.contacts.append(new)
        }
        self.table.reloadData()
    }
    
    private func readContact() {
        guard let user = Auth.auth().currentUser else { return }
        Environment.ref.child("users/\(user.uid)/contacts").observeSingleEvent(of: .value) { [weak self] snapshot in
            guard let contactsDict = (snapshot.value as? [String: Any]) else { return }
            self?.parseData(contactsDict)
        }
    }
}
extension SecondViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableViewCell.self), for: indexPath) as? TableViewCell else { return .init() }
        cell.setContact(contact: contacts[indexPath.row])
        return cell
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storybord = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storybord.instantiateViewController(withIdentifier: "ThirdViewController") as? ThirdViewController else { return }
        vc.mode = .edit(contacts[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
