//
//  ExtendedContactsTableViewController.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import UIKit

class ExtendedContactsTableViewController: UITableViewController {
    // MARK: - Properties
    var persons: [Person] = []
    private var dataManager: DataManager!
    
    private let cellIdentifier = "extendedContactCell"
    private let detailsVCIdentifier = "detailsVC"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Methods
    private func configure() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.rowHeight = 47
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        persons.count
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PersonTableViewCell
        
        cell.phoneLabel.text = persons[indexPath.section].phone
        cell.emailLabel.text = persons[indexPath.section].email
        
        cell.accessoryType = .disclosureIndicator
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let detailsVC = storyboard?.instantiateViewController(identifier: detailsVCIdentifier) as? DetailsViewController else { return }
        
        detailsVC.person = persons[indexPath.section]
        
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        persons[section].fullName
    }
    
}
