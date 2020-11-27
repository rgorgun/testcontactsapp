//
//  ContactListTableViewCell.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 25.11.2020.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let emptyContact = NSLocalizedString("emptyContact", comment: "")
}

/// Ячейка для отображения информации о контакте в списке
final class ContactListTableViewCell: UITableViewCell {
    // MARK: - Private Properties
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var imageContainerView: UIView!
    
    // MARK: - UIView
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        photoImageView.layer.cornerRadius = photoImageView.frame.height / 2
    }

    // MARK: - Public Methods
    
    func setup(contact: FetchedContact) {
        
        imageContainerView.isHidden = contact.image == nil
        photoImageView.image = contact.image

        nameLabel.isHidden = contact.fullName == nil && !contact.isEmpty
        phoneLabel.isHidden = contact.phoneNumbers.isEmpty
        
        nameLabel.text = contact.isEmpty ? Constants.emptyContact : contact.fullName
        phoneLabel.text = contact.phoneNumbers.first?.value
    }
    
    func setup(phone: ContactPhoneNumber) {
        imageContainerView.isHidden = true
      
        nameLabel.text = phone.label
        phoneLabel.text = phone.value
    }
}
