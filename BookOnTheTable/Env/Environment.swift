//
//  Environment.swift
//  BookOnTheTable
//
//  Created by administrator on 09/04/21.
//

import Foundation

class Environment{
    
    enum EnvironmentVariables: String {
        case apiBaseUrl = "API_BASE_URL"
    }
    
    static func variable(_ key: EnvironmentVariables) -> String{
        return Bundle.main.infoDictionary![key.rawValue] as! String
    }
}
