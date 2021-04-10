//
//  HomeViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 01/04/21.
//

import UIKit

class HomeViewController: UIViewController, UISearchBarDelegate{

    @IBOutlet weak var btnNewBook: UIButton!
    
    @IBOutlet weak var searchButton: UISearchBar!
    
    @IBOutlet weak var readingBookCollection: UICollectionView!
    @IBOutlet weak var toReadBookCollection: UICollectionView!
    @IBOutlet weak var alreadyReadBookCollection: UICollectionView!
    
    @IBOutlet weak var stackViewReading: UIStackView!
    @IBOutlet weak var stackViewToRead: UIStackView!
    @IBOutlet weak var stackViewAlreadyRead: UIStackView!
        
    let tableViewFiltered = UITableView()
    
    var listAllBooks:[Book] = []
    var listSearch:[Book] = []
    
    let statusArray: [String] = ["Lendo", "Para ler", "Já lidos"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        self.tableViewFiltered.isScrollEnabled = true
        self.tableViewFiltered.delegate = self
        self.tableViewFiltered.dataSource = self
        
        self.readingBookCollection.dataSource = self
        self.toReadBookCollection.dataSource = self
        self.alreadyReadBookCollection.dataSource = self
        
        self.readingBookCollection.delegate = self
        self.toReadBookCollection.delegate = self
        self.alreadyReadBookCollection.delegate = self
        
        self.searchButton.delegate = self
        
        ButtonNewBook().setup(btnNewBook)
        SearchButton().setup(searchButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        getBooks()
    }
    
    //MARK: - Get books
    func getBooks(){
        BookViewModel.viewModel.getAllBooks() { (books) in
            
            if books.count > 0 {
                self.listAllBooks = books
                self.listSearch = books
                self.readingBookCollection.reloadData()
                self.toReadBookCollection.reloadData()
                self.alreadyReadBookCollection.reloadData()
            }
        }
    }
       
    //MARK: - Search books
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        listSearch = listAllBooks
        
        if searchText != "" {
            let listAllBookFiltered = listAllBooks.filter { ($0.title?.lowercased().contains(searchText.lowercased()) ?? false)}
            listSearch = listAllBookFiltered
            
        }
        self.readingBookCollection.reloadData()
        self.toReadBookCollection.reloadData()
        self.alreadyReadBookCollection.reloadData()
    }
    
    //MARK: - Filter Book
    @IBAction func filterStatusBooks(_ sender: UIButton) {
        
        let action = UIAlertController(title: "Filtro", message: "Selecione status pra ocultar", preferredStyle: .actionSheet)
        action.view.tintColor = #colorLiteral(red: 1, green: 0.5607843137, blue: 0.3215686275, alpha: 1)
        action.setValue(NSAttributedString(string: action.title!, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: UIColor.black]), forKey: "attributedTitle")
        
        action.setValue(NSAttributedString(string: action.message!, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), NSAttributedString.Key.foregroundColor: UIColor.black]), forKey: "attributedMessage")
        
        let test = UIAlertAction(title: "", style: .default, handler: nil)
        action.addAction(test)
        action.addAction(test)
                
        let done = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        action.addAction(done)
        
        let rect = CGRect(x: 0.0, y: 60.0, width: action.view.frame.width - 16, height: 135)
        
        tableViewFiltered.frame = rect
        tableViewFiltered.layer.cornerRadius = 15
        tableViewFiltered.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        tableViewFiltered.clipsToBounds = true
        
        action.view.addSubview(tableViewFiltered)
        self.present(action, animated: true, completion: nil)
    }
    
    @IBAction func logoutButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        UserViewModel.viewModel.logoutUser()
    }
}

