//
//  DetailsBookViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit

class DetailsBookViewController: UIViewController {

    var bookSelected: Book? = nil
    @IBOutlet weak var stackBookDetail: UIStackView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var autherLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var btnRead: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        StackViewTop().setup(stackBookDetail)
        RoundedButton().setup(btnRead)
        
        setupContainer()
        
        if let book = bookSelected{
            self.titleLabel.text = book.title?.uppercased()
            self.autherLabel.text = book.author
            self.genreLabel.text = book.genre
            self.statusLabel.text = book.status
            
            if(book.status == "Done"){
                btnRead.isHidden = true
            }
        }
    }

    //MARK: - NavigationBar
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.3058823529, alpha: 1)
    }
    
    func setupContainer() {
        self.viewContainer.layer.cornerRadius = 20
        self.viewContainer.layer.borderColor = UIColor.lightGray.cgColor
        self.viewContainer.layer.borderWidth = 1.0
        self.viewContainer.clipsToBounds = true
    }

    @IBAction func deleteBook(_ sender: UIButton) {
        self.showAlertWith(title: "Atenção!", message: "Deseja realmente excluir livro?")
    }
    
    @IBAction func editBook(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "registerAndUpdateBook") as! RegisterBookViewController
        controller.bookSelected = bookSelected
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func markAsReadBook(_ sender: UIButton) {
        if (bookSelected != nil){
            bookSelected?.status = "Done"
            
            guard let idBook = bookSelected?.id else {return}
            BookViewModel.viewModel.updateBook(bookSelected!, String(describing: idBook)) { (response) in
                if let titleBook = response.title{
                    self.showAlertWith(title: "Sucesso!", message: "Status do livro \(titleBook) alterado para done", pop: true)
                    self.btnRead.isHidden = true
                    
                }else{
                    self.showAlertWith(title: "Impossivel cadastrar livro!", message: "Verifique sua conexão  com a internet \n ou tente novamente mais tarde...")
                }
            }
        }
    }
    
    //MARK: - Alert
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert, pop: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if(pop){
            let actionDelete = UIAlertAction(title: "OK", style: .default) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            alertController.addAction(actionDelete)
        }else{
            let actionOK = UIAlertAction(title: "SIM", style: .destructive) { (action) in
                self.dismiss(animated: true, completion:{() in
                    self.confirmDeleteBook()
                })
            }
            
            let actionCancel = UIAlertAction(title: "NÃO", style: .cancel) { (action) in
                self.dismiss(animated: true, completion: nil)
            }
            
            alertController.addAction(actionOK)
            alertController.addAction(actionCancel)
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc func confirmDeleteBook(){
        guard let idBook = bookSelected?.id else {return}
        
        BookViewModel.viewModel.deleteBook(String(describing: idBook)) { (statusCode) in
            if(statusCode == 204){
                self.navigationController?.popViewController(animated: true)
            }else{
                self.showAlertWith(title: "Atenção!", message: "Falha ao deletar livro...", pop:true)
            }
        }
    }
}
