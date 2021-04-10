//
//  BookViewModel.swift
//  BookOnTheTable
//
//  Created by administrator on 04/04/21.
//

import Foundation

class BookViewModel: NSObject{
    private override init(){}
    static let viewModel = BookViewModel()


    //MARK: - ADD BOOK
    func addBook(_ book: Book, completion: @escaping (Book) -> Void) {
        NetworkingBookService.shared.addBook(book, CoreDataUserService.shared.getToken()){(result) in
            switch result {
            case .success(let bookData):
                completion(bookData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
    
    //MARK: - GET ALL BOOKS
    func getAllBooks(completion: @escaping (_ books: [Book]) -> Void) {
        NetworkingBookService.shared.getAllBooks(CoreDataUserService.shared.getToken()){(result) in
            switch result {
            case .success(let bookData):
                completion(bookData)
                break
            case .failure(let error):
                completion([Book()])
                print(error)
                break
            }
        }
    }
    
    //MARK: - DELETE BOOK
    func deleteBook(_ id: String, completion: @escaping (_ statusCode: Int) -> Void) {
        NetworkingBookService.shared.deleteBook(CoreDataUserService.shared.getToken(), id){(result) in
            completion(result)
        }
    }
    
    //MARK: - UPDATE BOOK
    func updateBook(_ book: Book,_ id: String, completion: @escaping (Book) -> Void) {
        NetworkingBookService.shared.addBook(book, CoreDataUserService.shared.getToken(), id){(result) in
            switch result {
            case .success(let bookData):
                completion(bookData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
