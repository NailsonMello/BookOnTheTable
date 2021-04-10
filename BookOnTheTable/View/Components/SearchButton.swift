//
//  SearchButton.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class SearchButton {
    
    func setup(_ searchButton: UISearchBar){
        searchButton.tintColor = UIColor.white
        searchButton.barTintColor = UIColor.white
        searchButton.searchBarStyle = .minimal
        searchButton.searchTextField.backgroundColor = #colorLiteral(red: 1, green: 0.5607843137, blue: 0.3215686275, alpha: 1)
        searchButton.searchTextField.textColor = UIColor.white
        searchButton.searchTextField.bounds.size.height = 130
        searchButton.searchTextField.font?.withSize(25)
        searchButton.clipsToBounds = true
    }
}
