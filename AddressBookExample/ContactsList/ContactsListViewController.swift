//
//  ContactsListViewController.swift
//  AddressBook
//
//  Created by Raman Harhun on 25.11.2020.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let permissionError = NSLocalizedString("permissionError", comment: "")
    static let okText = NSLocalizedString("ok", comment: "")
    static let titleText = NSLocalizedString("addressbook", comment: "")
    static let emptyContactError = NSLocalizedString("emptyContactError", comment: "")
}

/// Экран для отображения списка контактов
final class ContactsListViewController: UIViewController {
    
    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!

    private lazy var dataSource = ContactsListDataSource(with: tableView)
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.titleText
        setupTableView()
        getContacts()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(nibCell: ContactListTableViewCell.self)
        tableView.dataSource = dataSource
    }
    
    private func getContacts() {
        ContactHelper.getContactPermission { [weak self] accessGranted in
            guard let self = self else { return }

            if !accessGranted {
                self.showAlert(with: Constants.permissionError)
                return
            }

            let result = ContactHelper.fetchContacts()
            if let error = result.error {
                self.showAlert(with: error.localizedDescription)
                return
            }
            
            self.dataSource.processContacts(result.contacts)
        }
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        alert.addAction(.init(title: Constants.okText, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate

extension ContactsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let contact = dataSource.contact(by: indexPath),
            !contact.isEmpty
        else {
            showAlert(with: Constants.emptyContactError)
            return
        }
        navigationController?.pushViewController(ContactInfoViewController.make(with: contact), animated: true)
    }
}


