//
//  ContactInfoViewController.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 26.11.2020.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let titleText = NSLocalizedString("info", comment: "")
    static let currentStoryboard = "Main"
}

/// Экран информции о контакте
final class ContactInfoViewController: UIViewController {

    // MARK: - Private Properties

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var headerView: ContactInfoHeaderView!
        
    private var contact: FetchedContact?
    
    // MARK: - UIViewController
    
    class func make(with contact: FetchedContact) -> ContactInfoViewController {
        let storyboard = UIStoryboard(name: Constants.currentStoryboard, bundle: nil)
        let identifier = "\(ContactInfoViewController.self)"
        let vc = storyboard.instantiateViewController(withIdentifier: identifier) as! ContactInfoViewController
        vc.contact = contact
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = Constants.titleText
        setupTableView()
        setupHeaderView()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView.register(nibCell: ContactListTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
    private func setupHeaderView() {
        guard
            let contact = contact,
            contact.image != nil
        else {
            headerView.isHidden = true
            return
        }
        
        headerView.setup(name: contact.fullName, image: contact.image)
        tableView.contentInset.top = headerView.frame.height
        tableView.scrollIndicatorInsets = tableView.contentInset
    }
}

// MARK: - UIScrollViewDelegate

extension ContactInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        headerView.updateHeight(scrollView.contentOffset.y)
    }
}

// MARK: - UITableViewDataSource

extension ContactInfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contact?.phoneNumbers.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let contact = contact else { return UITableViewCell() }
        let cell = tableView.dequeue(reusable: ContactListTableViewCell.self, for: indexPath)
        let phone = contact.phoneNumbers[indexPath.row]
        cell.setup(phone: phone)
        return cell
    }
}
