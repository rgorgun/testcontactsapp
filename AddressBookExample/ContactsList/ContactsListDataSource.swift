//
//  ContactsListDataSource.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 25.11.2020.
//

import UIKit

/// Вспомогательный класс для взаимодействия с таблицей
final class ContactsListDataSource: NSObject {
    // MARK: - Types
    
    private typealias ContactsSection = (letter: String, contacts: [FetchedContact])
    
    // MARK: - Private Properties
    
    private let tableView: UITableView
    private var sections = [ContactsSection]() {
        didSet { tableView.reloadData() }
    }
    
    // MARK: - Init
    
    init(with tableView: UITableView) {
        self.tableView = tableView
    }
    
    // MARK: - Public Methods
    
    func processContacts(_ contacts: [FetchedContact]) {
        let contactSections = Dictionary(grouping: contacts) { $0.fullName?.first ?? Character("*") }
            .map { (letter: String($0), contacts: $1) }
            .sorted(by: { $0.letter < $1.letter })
        sections = contactSections
    }
    
    func contact(by indexPath: IndexPath) -> FetchedContact? {
        guard
            indexPath.section < sections.count,
            indexPath.row < sections[indexPath.section].contacts.count
        else { return nil }
        return sections[indexPath.section].contacts[indexPath.row]
    }
}

// MARK: - UITableViewDataSource

extension ContactsListDataSource: UITableViewDataSource {
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sections.compactMap { $0.letter }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].letter
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = sections[indexPath.section].contacts[indexPath.row]
        let cell = tableView.dequeue(reusable: ContactListTableViewCell.self, for: indexPath)
        cell.setup(contact: contact)
        return cell
    }
}
