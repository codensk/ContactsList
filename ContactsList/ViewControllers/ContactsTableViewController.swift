//
//  ContactsTableViewController.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    // MARK: - Properties
    private var persons: [Person] = []
    private var dataManager: DataManager!
    
    private let cellIdentifier = "contactCell"
    private let detailsVCIdentifier = "detailsVC"

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    // MARK: - Methods
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tabBarController?.delegate = self
                
        dataManager = DataManager()
        persons = dataManager.chooseRandomData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = persons[indexPath.row].fullName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: detailsVCIdentifier) as? DetailsViewController else { return }
        
        detailsVC.person = persons[indexPath.row]
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

extension ContactsTableViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let navigationVC = viewController as? UINavigationController else { return }
        
        if let extendedVC = navigationVC.topViewController as? ExtendedContactsTableViewController {
            extendedVC.persons = persons
        }
        
    }
}
