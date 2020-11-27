//
//  UITableView.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 26.11.2020.
//

import UIKit
 
extension UITableView {
    func register<T: UITableViewCell>(nibCell identifier: T.Type) {
        let identifierString = String(describing: identifier)
        let nib = UINib(nibName: identifierString, bundle: nil)
        register(nib, forCellReuseIdentifier: identifierString)
    }
    
    func dequeue<T: UITableViewCell>(reusable identifier: T.Type, for indexPath: IndexPath) -> T {
        let identifierString = String(describing: identifier)
        return dequeueReusableCell(withIdentifier: identifierString, for: indexPath) as! T
    }
}
