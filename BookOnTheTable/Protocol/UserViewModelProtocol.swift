//
//  UserViewModelProtocol.swift
//  BookOnTheTable
//
//  Created by administrator on 03/04/21.
//

import Foundation

protocol UserViewModelProtocol {
    func addUser(_ user: User, completion: @escaping(Swift.Result<User, Error>) -> Void)
    func login(_ user: LoginUser, completion: @escaping(Swift.Result<User, Error>) -> Void)
}
