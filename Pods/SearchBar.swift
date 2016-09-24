//
//  SearchBar.swift
//  Pods
//
//  Created by Mariah Sami Khayat on 9/24/16.
//
//

import UIKit

class TextField: UITextField {
    override var placeholder: String? {
        didSet {
            let placeholderString = NSAttributedString(string: placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
            self.attributedPlaceholder = placeholderString
        }
    }
}

