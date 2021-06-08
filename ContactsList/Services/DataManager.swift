//
//  DataManager.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import Foundation

class DataManager {
    // MARK: - Properties
    private var firstNames = ["James", "Robert", "John", "Michael", "William", "David", "Patricia", "Mary", "Jennifer", "Linda"]
    private var lastNames = ["Wilson", "Burton", "Harris", "Stevens", "Robinson", "Lewis", "Walker", "Payne", "Baker", "Owen"]
    private var emails = ["prog@yandex.ru", "home@yandex.ru", "work@yandex.ru", "sales@yandex.ru", "it@company.com", "ceo@apple.com", "hr@apple.com", "order@shop.ru", "ios@it.ru", "director@comp.com"]
    private var phones = ["89991112233", "89501234567", "89154704940", "89131112345", "89511234567", "88146623417", "89134566543", "89091237221", "89648765432", "89092223456"]
    
    func chooseRandomData() -> [Person] {
        let maxItems = firstNames.count

        var persons: [Person] = []
                
        var firstNames = firstNames.shuffled()
        var lastNames = lastNames.shuffled()
        var emails = emails.shuffled()
        var phones = phones.shuffled()
        
        for _ in 0..<maxItems {
            persons.append(Person(
                            firstName: firstNames.removeFirst(),
                            lastName: lastNames.removeFirst(),
                            email: emails.removeFirst(),
                            phone: phones.removeFirst()
            ))
        }
        
        return persons
    }
}
