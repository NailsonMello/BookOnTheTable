//
//  RoundedTextField.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class RoundedTextField {
    func setup(_ txtField: UITextField) {
        
        let leftPadding = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txtField.frame.height))
        txtField.leftView = leftPadding
        txtField.leftViewMode = .always
        txtField.layer.cornerRadius = 30
        let color = UIColor.lightGray
        txtField.layer.borderColor = color.cgColor
        txtField.layer.borderWidth = 1.0
        txtField.clipsToBounds = true
    }
}
