//
//  ReadingBookCollectionViewCell.swift
//  BookOnTheTable
//
//  Created by administrator on 05/04/21.
//

import UIKit

class ReadingBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleBookReading: UILabel!
    @IBOutlet weak var authorBookReading: UILabel!
    
    func configureCell(_ book: Book){
        titleBookReading.text = book.title
        authorBookReading.text = book.author
        
        layer.cornerRadius = 10
        layer.borderWidth = 1
        let color = UIColor.lightGray
        layer.borderColor = color.cgColor
    }
    
}
