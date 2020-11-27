//
//  FetchedContact.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 25.11.2020.
//

import Contacts
import UIKit

// MARK: - Constants

private enum Constants {
    static let separatorCharacter: Character = " "
    static let sideSize: CGFloat = 100
    static let defaultFontSize: CGFloat = 30
}

/// Модель для работы с контактом
struct FetchedContact {
    // Полное имя
    var fullName: String?
    // Все номера
    var phoneNumbers: [ContactPhoneNumber]
    // Фото
    var image: UIImage?
    // Вычисляемые инициалы
    var initials: String? {
        guard
            let words = fullName?.split(separator: Constants.separatorCharacter),
            !words.isEmpty,
            let firstWordLetter = words.first?.first
        else { return nil }
        
        guard
            words.count > 1,
            let lastWordLetter = words.last?.first
        else { return String(firstWordLetter) }
        
        return "\(String(firstWordLetter)) \(String(lastWordLetter))"
    }
    // Флаг контакта без данных
    var isEmpty: Bool {
        fullName == nil && phoneNumbers.isEmpty && image == nil
    }
    
    // MARK: - Init
    
    init(contact: CNContact) {
        fullName = CNContactFormatter.string(from: contact, style: .fullName)
        phoneNumbers = contact.phoneNumbers.compactMap { phone in
            guard let label = phone.label else { return nil }
            let localizedLabel = CNLabeledValue<NSString>.localizedString(forLabel: label)
            return .init(label: localizedLabel, value: phone.value.stringValue)
        }
        
        guard let imageData = contact.imageData else {
            let defaultSize = CGSize(width: Constants.sideSize, height: Constants.sideSize)
            image = initials?.image(
                font: .boldSystemFont(ofSize: Constants.defaultFontSize),
                rect: .init(origin: .zero, size: defaultSize)
            )
            return
        }
        image = UIImage(data: imageData)
    }
}

/// Модель для работы с номерами
struct ContactPhoneNumber {
    // Тип номера
    var label: String
    // Значение номера
    var value: String
}
