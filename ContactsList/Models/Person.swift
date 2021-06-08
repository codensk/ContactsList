//
//  Person.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

struct Person {
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    
    var fullName: String {
        "\(firstName) \(lastName)"
    }
}
