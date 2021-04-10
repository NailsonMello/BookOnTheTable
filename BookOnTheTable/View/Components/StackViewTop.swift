//
//  StackViewTop.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class StackViewTop {
    func setup(_ stackView: UIStackView) {
       
        stackView.layer.cornerRadius = 40
        stackView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        stackView.clipsToBounds = true
    }
}
