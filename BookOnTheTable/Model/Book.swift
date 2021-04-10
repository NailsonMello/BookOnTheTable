//
//  Book.swift
//  BookOnTheTable
//
//  Created by administrator on 04/04/21.
//

import Foundation

struct Book: Encodable, Decodable {
    var title: String?
    var author: String?
    var genre: String?
    var status: String?
    var id: UUID?
    
    private enum CodingKeys: String, CodingKey{
        case title
        case author
        case genre
        case status
        case id
    }
}
