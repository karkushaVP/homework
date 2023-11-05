//
//  File.swift
//  Homework
//
//  Created by Polya on 8.10.23.
//

import Foundation

struct Contact: Editable {
    var id: String?
    let name: String
    let surname: String?
    let country: String?
    let city: String?
    let phone: String

    
    var asDict: [String: Any] {
        var dict = [String: Any]()
        dict["name"] = name
        dict["surname"] = surname
        dict["country"] = country
        dict["city"] = city
        dict["phone"] = phone
        return dict
    }
    
    init(
        id: String? = nil,
        name: String,
        surname: String? = nil,
        country:String? = nil,
        city: String? = nil,
        phone: String
    ) {
        self.id = id
        self.name = name
        self.surname = surname
        self.country = country
        self.city = city
        self.phone = phone
    }
    
    init(key: String, dict: [String: Any]) throws {
        guard let name = dict["name"] as? String,
              let phone = dict["phone"] as? String
        else {
            let error = "Parsing contact error"
            print("[Contact parser] \(error)")
            throw error
        }
        
            self.id = key
            self.name = name
            self.surname = dict["surname"] as? String
            self.country = dict["country"] as? String
            self.city = dict["city"] as? String
            self.phone = phone
    }
}

extension String: Error {}

protocol Editable {
    var id: String? { get }
}
