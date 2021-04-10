//
//  ImageButton.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class ImageButton {
    func addLeftImageTo(_ txtField: UITextField, _ img: UIImage){
        
        let size = 30
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(txtField.frame.height), height: Int(txtField.frame.height)))
        let leftImageView = UIImageView(frame: CGRect(x: 15, y: size / Int(2), width: size, height: size))
        leftImageView.image = img
        
        view.addSubview(leftImageView)
        txtField.leftView = view
        txtField.leftViewMode = .always
    }
}
