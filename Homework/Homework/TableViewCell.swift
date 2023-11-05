//
//  TableViewCell.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

var contact: Contact?

class TableViewCell: UITableViewCell {
    
    var contact: Contact?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    private func configure() {
        guard let contact else { return }
        nameLabel.text = "\(contact.name) \(contact.surname ?? "")"
        phoneLabel.text = "+\(contact.phone)"
    }
    
    func setContact(contact: Contact) {
        self.contact = contact
        configure()
    }

}
