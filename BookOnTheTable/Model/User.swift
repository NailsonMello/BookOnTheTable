//
//  User.swift
//  BookOnTheTable
//
//  Created by administrator on 03/04/21.
//

import Foundation

struct User: Encodable, Decodable {
    var name: String?
    var email: String?
    var password: String?
    var token: String?
    //var Id: UUID?
    
    private enum CodingKeys: String, CodingKey{
        case name
        case email
        case password
        case token
        //case Id = "user_id"
    }
}

struct LoginUser: Encodable {
    var email: String?
    var password: String?
   
    private enum CodingKeys: String, CodingKey{
        case email
        case password
    }
}
