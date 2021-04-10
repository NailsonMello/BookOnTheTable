//
//  UserViewModel.swift
//  BookOnTheTable
//
//  Created by administrator on 03/04/21.
//

import Foundation

class UserViewModel: NSObject{
    
    private override init(){}
    static let viewModel = UserViewModel()
    

    //MARK: - ADD USER
    func addUser(_ user: User, completion: @escaping (User) -> Void) {
        NetworkingUserService.shared.addUser(user){(result) in
            switch result {
            case .success(let userData):
                completion(userData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    //MARK: - LOGIN
    func login(_ user: LoginUser, completion: @escaping (User) -> Void){
        NetworkingUserService.shared.login(user){(result) in
            switch result {
            case .success(let userData):
                CoreDataUserService.shared.saveToken(userData.token ?? "")
                completion(userData)
                break
            case .failure(let error):
                print(error)
                completion(User())
                break
            }
        }
    }
       
    //MARK: - USER LOGGED
    func loggedUser() -> Bool{
        let hasToken = CoreDataUserService.shared.getToken()
        if (hasToken != "") {
            return true
        }else{
            return false
        }
    }
    
    //MARK: - USER LOGOUT
    func logoutUser(){
        CoreDataUserService.shared.deleteToken("TokenUser")
    }
}
