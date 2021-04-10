//
//  NetworkingBookService.swift
//  BookOnTheTable
//
//  Created by administrator on 04/04/21.
//

import Foundation
import Alamofire

class NetworkingBookService{
    private init(){}
    static let shared = NetworkingBookService()
    

    func addBook(_ book: Book, _ token: String, _ id:String? = nil, completion: @escaping(Swift.Result<Book, Error>) -> Void){
        guard let url = URL(string: "\(Environment.variable(.apiBaseUrl))books/\(id ?? "")") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = id != nil ? "PUT" : "POST"
        let jsonUser = try! JSONEncoder().encode(book)
        request.httpBody = jsonUser
        request.allHTTPHeaderFields = HttpHeader.hearder(token)
        
        Alamofire.request(request).responseData{(response) in
            switch response.result{
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(Book.self, from: response.result.value!)
                
                    completion(.success(jsonData))
                }catch let error{
                    completion(.failure(error))
                }
                break
            case .failure:
                let statusCode = response.response?.statusCode
                if statusCode == 401 {
                    CoreDataUserService.shared.deleteToken("TokenUser")
                }
                print(response.error!)
                completion(.failure(response.error!))
                break
            }
        }
    }
    
    func getAllBooks(_ token: String, completion: @escaping(Swift.Result<[Book], Error>) -> Void){

        Alamofire.request("\(Environment.variable(.apiBaseUrl))books?per=100", method: .get, headers:HttpHeader.hearder(token)).responseData{(response) in
            switch response.result{
            case .success:
                do{
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(BookList.self, from: response.result.value!)
                    completion(.success(jsonData.books))
                    
                }catch let error{
                    completion(.failure(error))
                }
                break
            case .failure:
                let statusCode = response.response?.statusCode
                if statusCode == 401 {
                    CoreDataUserService.shared.deleteToken("TokenUser")
                }
                print(response.error!)
                completion(.failure(response.error!))
                break
            }
        }
    }
    
    func deleteBook(_ token: String, _ id: String, completion: @escaping(_ response: Int) -> Void){
            
        Alamofire.request("\(Environment.variable(.apiBaseUrl))books/\(id)", method: .delete, headers:HttpHeader.hearder(token)).responseData{(response) in
            let statusCode = response.response?.statusCode
            switch response.result{
            case .success:
                if statusCode == 204 {
                    completion(statusCode!)
                }
                break
            case .failure:
                if statusCode == 401 {
                    CoreDataUserService.shared.deleteToken("TokenUser")
                }
                print(response.error!)
                completion(statusCode!)
                break
            }
        }
    }
}
