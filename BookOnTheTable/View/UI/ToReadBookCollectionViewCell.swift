//
//  ToReadBookCollectionViewCell.swift
//  BookOnTheTable
//
//  Created by administrator on 05/04/21.
//

import UIKit

class ToReadBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleBookRead: UILabel!
    @IBOutlet weak var authorBookRead: UILabel!
    
    func configureCell(_ book: Book){
        titleBookRead.text = book.title
        authorBookRead.text = book.author
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        let color = UIColor.lightGray
        layer.borderColor = color.cgColor
    }
}
