//
//  AlreadyReadBookCollectionViewCell.swift
//  BookOnTheTable
//
//  Created by administrator on 05/04/21.
//

import UIKit

class AlreadyReadBookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleBookAlreadyRead: UILabel!
    @IBOutlet weak var authorBookAlreadyRead: UILabel!
    
    func configureCell(_ book: Book){
        titleBookAlreadyRead.text = book.title
        authorBookAlreadyRead.text = book.author
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        let color = UIColor.lightGray
        layer.borderColor = color.cgColor
    }
}
