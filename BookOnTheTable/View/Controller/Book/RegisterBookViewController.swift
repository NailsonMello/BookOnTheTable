//
//  RegisterBookViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 04/04/21.
//

import UIKit

class RegisterBookViewController: UIViewController {

    var bookSelected: Book? = nil
    
    @IBOutlet weak var stackBookRegister: UIStackView!
    
    @IBOutlet weak var btnBookRegister: UIButton!
    
    @IBOutlet weak var txtTitleBook: UITextField!
    @IBOutlet weak var txtAuthorBook: UITextField!
    @IBOutlet weak var selectGenreBook: UIButton!
    @IBOutlet weak var selectStatusBook: UIButton!
    
    @IBOutlet weak var scrollViewBookRegister: UIScrollView!
    
    let transparentView = UIView()
    let tableView = UITableView()
    var selectedButton = UIButton()
    var dataSource = [String]()
    
    var book = Book()
    var isGenre: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        StackViewTop().setup(stackBookRegister)
                
        RoundedButton().setup(btnBookRegister)
        RoundedButton().setup(selectGenreBook, true)
        RoundedButton().setup(selectStatusBook, true)
        
         
        RoundedTextField().setup(txtTitleBook)
        RoundedTextField().setup(txtAuthorBook)
        
        setupUpdateBook()
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseScrollView(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    func setupUpdateBook(){
        if let book = bookSelected{
            self.txtTitleBook.text = book.title
            self.txtAuthorBook.text = book.author
            self.selectGenreBook.setTitle(book.genre, for: .normal)
            self.selectStatusBook.setTitle(book.status, for: .normal)
            self.book.genre = book.genre
            self.book.status = book.status
            self.book.id = book.id
        }
    }
    
    //MARK: - NavigationBar
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.3058823529, alpha: 1)
    }
    
    //MARK: - ScrollView
    @objc func increaseScrollView(_ notification: Notification){
        self.scrollViewBookRegister.contentSize = CGSize(width: self.scrollViewBookRegister.frame.width, height: scrollViewBookRegister.frame.height + self.scrollViewBookRegister.frame.height / 2)
    }
    
    func addTransparentView(frames: CGRect, _ position: Int) {
        let window = self.view.window
             transparentView.frame = window?.frame ?? self.view.frame
             self.view.addSubview(transparentView)
             
             tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
             self.view.addSubview(tableView)
             tableView.layer.cornerRadius = 5
             
             transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
             tableView.reloadData()
             let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
             transparentView.addGestureRecognizer(tapgesture)
             transparentView.alpha = 0
             UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                 self.transparentView.alpha = 0.5
                self.tableView.frame = CGRect(x: frames.origin.x + 25, y: CGFloat(position) + frames.height + CGFloat(position), width: frames.width, height: CGFloat(self.dataSource.count * 50))
             }, completion: nil)
         }
    
    @objc func removeTransparentView() {
             let frames = selectedButton.frame
             UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
                 self.transparentView.alpha = 0
                 self.tableView.frame = CGRect(x: frames.origin.x, y: frames.origin.y + frames.height, width: frames.width, height: 0)
             }, completion: nil)
         }
    
    @IBAction func onClickSelectGenre(_ sender: UIButton) {
        isGenre = true
        dataSource = ["Horror", "Romance", "Comedia"]
        selectedButton = selectGenreBook
        addTransparentView(frames: selectGenreBook.frame, 30)
    }
         
    @IBAction func onClickSelectStatus(_ sender: UIButton) {
        isGenre = false
        dataSource = ["Reading", "Done"]
        selectedButton = selectStatusBook
        addTransparentView(frames: selectStatusBook.frame, 30)
    }
    
    @IBAction func onClickAddNewBook(_ sender: UIButton) {
        guard let title = txtTitleBook.text, !title.isEmpty else {
            self.showAlertWith(title: "Atenção!", message: "Campo titulo não poder ser vazio!!!")
            return
            
        }
        guard let author = txtAuthorBook.text, !author.isEmpty else {
            self.showAlertWith(title: "Atenção!", message: "Campo autor não poder ser vazio!!!")
            return
            
        }
        
        book.title = title
        book.author = author
        
        if(book.genre == nil){
            self.showAlertWith(title: "Atenção!", message: "Você precisa selecionar o genero!!!")
            return
        }
        
        if(book.status == nil){
            self.showAlertWith(title: "Atenção!", message: "Você precisa selecionar o status!!!")
            return
        }
        
        if(bookSelected != nil){
            updateBook()
        }else{
            addBook()
        }
    }
    
    func addBook(){
        BookViewModel.viewModel.addBook(book) { (response) in
            if let titleBook = response.title{
                
                self.showAlertWith(title: "Sucesso!", message: "Livro \(titleBook) cadastrado com sucesso", pop: true)
                
            }else{
                self.showAlertWith(title: "Impossivel cadastrar livro!", message: "Verifique sua conexão  com a internet \n ou tente novamente mais tarde...")
            }
        }
    }
    
    func updateBook(){
        guard let idBook = bookSelected?.id else {return}
        BookViewModel.viewModel.updateBook(book, String(describing: idBook)) { (response) in
            if let titleBook = response.title{
                
                self.showAlertWith(title: "Sucesso!", message: "Livro \(titleBook) alterado com sucesso", pop: true)
                
            }else{
                self.showAlertWith(title: "Impossivel cadastrar livro!", message: "Verifique sua conexão  com a internet \n ou tente novamente mais tarde...")
            }
        }
    }
    
    //MARK: - Alert
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert, pop: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let actionOK = UIAlertAction(title: "OK", style: .default) { (action) in
            if pop == true{
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }

        alertController.addAction(actionOK)
        self.present(alertController, animated: true, completion: nil)
    }
}
