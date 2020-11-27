//
//  ContactInfoHeaderView.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 26.11.2020.
//

import UIKit

// MARK: - Constants

private enum Constants {
    static let maxHeaderHeight: CGFloat = 250
    static let minHeaderHeight: CGFloat = 150
}

/// Вью хедера с динамической фото контакта
final class ContactInfoHeaderView: UIView {
    
    // MARK: - Private Properties

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var contactImageView: UIImageView!
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var contentView: UIView!

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateImageCorners()
    }
    
    // MARK: - Public Methods

    func setup(name: String?, image: UIImage?) {
        contactImageView.image = image
        nameLabel.text = name
    }
    
    func updateHeight(_ offset: CGFloat) {
        if offset < -Constants.maxHeaderHeight {
            heightConstraint.constant = Constants.maxHeaderHeight
        } else if offset < -Constants.minHeaderHeight {
            heightConstraint.constant = -offset
        } else {
            heightConstraint.constant = Constants.minHeaderHeight
        }
    }
    
    // MARK: - Private Methods

    private func commonInit() {
        Bundle.main.loadNibNamed("\(ContactInfoHeaderView.self)", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
    }
    
    private func updateImageCorners() {
        DispatchQueue.main.async {
            self.contactImageView.layer.cornerRadius = self.contactImageView.frame.height / 2
        }
    }
}
