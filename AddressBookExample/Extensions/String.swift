//
//  String.swift
//  AddressBookExample
//
//  Created by Raman Harhun on 25.11.2020.
//

import UIKit

extension String {
    func image(
        font: UIFont,
        textColor: UIColor = .white,
        backgroundColor: UIColor = .random,
        rect: CGRect
    ) -> UIImage? {
        let textLabel = UILabel(frame: rect)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = backgroundColor
        textLabel.textColor = textColor
        textLabel.font = font
        textLabel.text = self
        UIGraphicsBeginImageContextWithOptions(rect.size, false, .zero)
        guard let currentContext = UIGraphicsGetCurrentContext() else { return nil }
        textLabel.layer.render(in: currentContext)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
