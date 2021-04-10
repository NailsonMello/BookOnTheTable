//
//  RoundedButton.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class RoundedButton {
    func setup(_ button: UIButton, _ hasBorder: Bool = false){
        button.layer.cornerRadius = 30
            
        if(hasBorder){
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
            let color = UIColor.lightGray
            button.layer.borderColor = color.cgColor
            button.layer.borderWidth = 1.0
        }
        
        button.clipsToBounds = true
    }
}
