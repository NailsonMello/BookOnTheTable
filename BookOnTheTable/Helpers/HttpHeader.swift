//
//  HttpHeader.swift
//  BookOnTheTable
//
//  Created by administrator on 09/04/21.
//

import Foundation

class HttpHeader{
    static func hearder(_ token: String) -> [String: String]{
        let headers = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"
        ]
        
        return headers
    }
}
