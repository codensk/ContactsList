//
//  ContactsTableViewController.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import UIKit

enum Identifier: String {
    case contactsCell = "contactCell"
    case extendedContactsCell = "extendedContactCell"
    case detailsVC = "detailsVC"
    case addContactVC = "addContactVC"
}

protocol ContactsDelegate {
    func addContact(firstName: String, lastName: String, phone: String, email: String)
    func updateTable()
}

class ContactsTableViewController: UITableViewController {
    // MARK: - Properties
    private var persons: [Person] = []
    private var dataManager: DataManager!

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Methods
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addContactButton))
        navigationItem.leftBarButtonItem = editButtonItem
        
        tabBarController?.delegate = self
                
        dataManager = DataManager()
        persons = dataManager.chooseRandomData()
    }
    
    @objc private func addContactButton() {
        guard let addContactVC = storyboard?.instantiateViewController(identifier: Identifier.addContactVC.rawValue) as? AddContactViewController else { return }
        
        addContactVC.delegate = self
        
        navigationController?.pushViewController(addContactVC, animated: true)
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.contactsCell.rawValue, for: indexPath)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = persons[indexPath.row].fullName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: Identifier.detailsVC.rawValue) as? DetailsViewController else { return }
        
        detailsVC.person = persons[indexPath.row]
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            persons.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}

// MARK: - Extensions
extension ContactsTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationVC = viewController as? UINavigationController else { return }
        
        if let extendedVC = navigationVC.topViewController as? ExtendedContactsTableViewController {
            extendedVC.persons = persons
        }
        
    }
}

extension ContactsTableViewController: ContactsDelegate {
    func addContact(firstName: String, lastName: String, phone: String, email: String) {
        persons.append(Person(firstName: firstName, lastName: lastName, email: email, phone: phone))
        updateTable()
    }
    
    func updateTable() {
        tableView.reloadData()
    }
}
