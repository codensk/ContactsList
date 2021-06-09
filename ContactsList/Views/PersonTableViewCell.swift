//
//  PersonTableViewCell.swift
//  ContactsList
//
//  Created by SERGEY VOROBEV on 08.06.2021.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
