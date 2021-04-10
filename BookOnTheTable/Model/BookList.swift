//
//  BookList.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import Foundation

struct BookList: Encodable, Decodable {
    var books: [Book]
    
    private enum CodingKeys: String, CodingKey{
        case books = "items"
    }
}
