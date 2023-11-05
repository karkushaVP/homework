//
//  Inviroment.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import Foundation
import FirebaseDatabase

struct Environment {
    static let ref = Database.database(url: "https://homework2-de05f-default-rtdb.europe-west1.firebasedatabase.app/").reference()
}
