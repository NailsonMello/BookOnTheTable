//
//  ButtonNewBook.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class ButtonNewBook {
    func setup(_ btnNewBook: UIButton) {
        btnNewBook.layer.cornerRadius = 0.5 * btnNewBook.bounds.size.width
        btnNewBook.layer.borderColor = UIColor.white.cgColor
        btnNewBook.layer.borderWidth = 8.0
        btnNewBook.clipsToBounds = true
    }
}
