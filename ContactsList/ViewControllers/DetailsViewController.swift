//
//  DetailsViewController.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    @IBOutlet var iconImageView: [UIImageView]!
    
    // MARK: - Properties
    var person: Person!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configurePerson()
    }
    
    // MARK: - IBActions
    @IBAction func phoneCallButton() {
        callAction(for: "tel", value: person.phone)
    }
    
    @IBAction func emailWriteButton() {
        callAction(for: "mailto", value: person.email)
    }
    
    // MARK: - Methods
    private func configureViews() {
        iconImageView.forEach { $0.tintColor = .systemGray2 }
        
        photoImageView.image = UIImage(named: "avatar")
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
        
        fullNameLabel.textAlignment = .center
        fullNameLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }

    private func configurePerson() {
        fullNameLabel.text = person.fullName
        fullNameLabel.text = person.fullName
        
        phoneLabel.text = person.phone
        emailLabel.text = person.email
    }
    
    private func callAction(for schema: String, value: String) {
        let protocolSuffix = schema == "tel" ? "//\(value)" : value
        
        if let callUrl = URL(string: "\(schema):\(protocolSuffix)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(callUrl)) {
                application.open(callUrl, options: [:])
            }
        }
    }

}
