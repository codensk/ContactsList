//
//  AddContactViewController.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 09.06.2021.
//

import UIKit

class AddContactViewController: UIViewController {
    @IBOutlet var iconImage: [UIImageView]!
    @IBOutlet var personLabel: [UILabel]!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var addButton: UIButton!
    
    var delegate: ContactsDelegate!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        configureTextFields()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    @IBAction func addButtonTapped() {
        guard let firstName = firstNameTextField.text,
              let lastName = lastNameTextField.text,
              let phone = phoneTextField.text,
              let email = emailTextField.text else { return }
        
        
        if firstName.isEmpty {
            showAlert(title: "Ошибка", message: "Укажите имя")
        } else if lastName.isEmpty {
            showAlert(title: "Ошибка", message: "Укажите фамилию")
        } else if phone.isEmpty {
            showAlert(title: "Ошибка", message: "Укажите номер телефона")
        } else if email.isEmpty {
            showAlert(title: "Ошибка", message: "Укажите адрес электронной почты")
        } else {
            delegate.addContact(firstName: firstName, lastName: lastName, phone: phone, email: email)
            
            navigationController?.popToRootViewController(animated: true)
        }
    }

    // MARK: - Methods
    private func configureViews() {
        iconImage.forEach { $0.tintColor = .systemGray2 }
        personLabel.forEach { $0.font = UIFont.boldSystemFont(ofSize: 17) }
        
        firstNameTextField.placeholder = "Имя"
        lastNameTextField.placeholder = "Фамилия"
        phoneTextField.placeholder = "Например, 89131234567"
        emailTextField.placeholder = "name@site.ru"
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
        addButton.backgroundColor = UIColor(named: "Button")
        addButton.setTitleColor(.white, for: .normal)
    }
    
    private func configureTextFields() {
        let textFields = [firstNameTextField, lastNameTextField, phoneTextField, emailTextField]
        
        textFields.forEach { textField in
            if let textField = textField {
                let bottomBorder = UIView()
                
                bottomBorder.backgroundColor = .systemGray5
                
                textField.textColor = .systemGray
                textField.borderStyle = .none
                textField.addSubview(bottomBorder)
                
                bottomBorder.translatesAutoresizingMaskIntoConstraints = false
                
                textField.delegate = self
                
                if textField == phoneTextField {
                    let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
                    let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
                    let doneBarButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(phoneReturnKeyboardPressed))
                    
                    keyboardToolbar.sizeToFit()
                    keyboardToolbar.barStyle = .default
                    keyboardToolbar.items = [flexBarButton, doneBarButton]
                    
                    textField.inputAccessoryView = keyboardToolbar
                }
                
                // add constraints for bottom line
                bottomBorder.bottomAnchor.constraint(equalTo: textField.bottomAnchor).isActive = true
                bottomBorder.leftAnchor.constraint(equalTo: textField.leftAnchor).isActive = true
                bottomBorder.rightAnchor.constraint(equalTo: textField.rightAnchor).isActive = true
                bottomBorder.heightAnchor.constraint(equalToConstant: 2).isActive = true
                
            }
        }
        
        firstNameTextField.returnKeyType = .next
        lastNameTextField.returnKeyType = .next
        phoneTextField.returnKeyType = .next
        emailTextField.returnKeyType = .done
    }
    
    @objc func phoneReturnKeyboardPressed() {
        emailTextField.becomeFirstResponder()
    }
}

// MARK: - Extensions
extension AddContactViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstNameTextField:
            lastNameTextField.becomeFirstResponder()
        case lastNameTextField:
            phoneTextField.becomeFirstResponder()
        case phoneTextField:
            emailTextField.becomeFirstResponder()
        default:
            addButtonTapped()
        }
        
        return true
    }
}
