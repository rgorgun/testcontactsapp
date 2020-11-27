//
//  ContactManager.swift
//  AddressBook
//
//  Created by Raman Harhun on 25.11.2020.
//

import Contacts

/// Хелпер для работы с контактами телефона
final class ContactHelper: NSObject {

    // Запрос на предоставление разрешения для работы с контактами
    class func getContactPermission(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let authorizationStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch authorizationStatus {
        case .authorized:
            completionHandler(true)
        case .denied, .notDetermined:
            CNContactStore().requestAccess(for: CNEntityType.contacts, completionHandler: { access, _ in
                DispatchQueue.main.async {
                    completionHandler(access)
                }
            })
        default:
            completionHandler(false)
        }
    }
    
    // Считывание контактов из записной книги юзера
    class func fetchContacts() -> (contacts: [FetchedContact], error: Error?) {
        let store = CNContactStore()
        let keys = [
            CNContactPhoneNumbersKey as CNKeyDescriptor,
            CNContactImageDataKey as CNKeyDescriptor,
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName)
        ]
        let request = CNContactFetchRequest(keysToFetch: keys)
        var contacts = [FetchedContact]()
        var fetchError: Error?
        
        do {
            try store.enumerateContacts(with: request, usingBlock: { contact, _ in contacts.append(.init(contact: contact)) })
        } catch let error {
            fetchError = error
        }
        
        return (contacts, fetchError)
    }
}
