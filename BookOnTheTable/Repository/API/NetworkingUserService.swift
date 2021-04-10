//
//  NetworkingUserService.swift
//  BookOnTheTable
//
//  Created by administrator on 03/04/21.
//

import Foundation
import Alamofire

class NetworkingUserService{
    private init(){}
    static let shared = NetworkingUserService()
    

    func addUser(_ user: User, completion: @escaping(Swift.Result<User, Error>) -> Void){
        guard let url = URL(string: "\(Environment.variable(.apiBaseUrl))users") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonUser = try! JSONEncoder().encode(user)
        request.httpBody = jsonUser
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(request).responseData{(response) in
            switch response.result{
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(User.self, from: response.result.value!)
                
                    completion(.success(jsonData))
                }catch let error{
                    completion(.failure(error))
                }
                break
            case .failure:
                print(response.error!)
                completion(.failure(response.error!))
                break
            }
        }
    }
    
    func login(_ user: LoginUser, completion: @escaping(Swift.Result<User, Error>) -> Void){
        guard let url = URL(string: "\(Environment.variable(.apiBaseUrl))security/token") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let jsonUser = try! JSONEncoder().encode(user)
        request.httpBody = jsonUser
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        Alamofire.request(request).responseData{(response) in
            switch response.result{
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(User.self, from: response.result.value!)
                
                    completion(.success(jsonData))
                }catch let error{
                    completion(.failure(error))
                }
                break
            case .failure:
                print(response.error!)
                completion(.failure(response.error!))
                break
            }
        }
    }
}
