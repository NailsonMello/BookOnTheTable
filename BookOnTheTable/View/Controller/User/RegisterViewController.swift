//
//  RegisterViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 01/04/21.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var stackRegister: UIStackView!
    
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var txtEmailRegister: UITextField!
    @IBOutlet weak var txtConfirmPasswordRegister: UITextField!
    @IBOutlet weak var txtPasswordRegister: UITextField!
    @IBOutlet weak var txtFullnameRegister: UITextField!
    
    @IBOutlet weak var scrollViewRegister: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StackViewTop().setup(stackRegister)
        
        RoundedButton().setup(btnRegister)

        RoundedTextField().setup(txtFullnameRegister)
        RoundedTextField().setup(txtEmailRegister)
        RoundedTextField().setup(txtPasswordRegister)
        RoundedTextField().setup(txtConfirmPasswordRegister)
        ImageButton().addLeftImageTo(txtFullnameRegister, UIImage(named: "user")!)
        ImageButton().addLeftImageTo(txtEmailRegister, UIImage(named: "email")!)
        ImageButton().addLeftImageTo(txtPasswordRegister, UIImage(named: "key")!)
        ImageButton().addLeftImageTo(txtConfirmPasswordRegister, UIImage(named: "key")!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseScrollView(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar()
    }
    

    //MARK: - Send user
    @IBAction func sendUser(_ sender: UIButton) {
        
        guard let email = txtEmailRegister.text, let fullname = txtFullnameRegister.text, let password = txtPasswordRegister.text, let confirmPassword = txtConfirmPasswordRegister.text else {return}
        
        if password == confirmPassword{
            let user = User(name: fullname, email: email, password: password)
            UserViewModel.viewModel.addUser(user) { (response) in
                if let nameUser = response.name{
                    
                    self.showAlertWith(title: "Sucesso!", message: "Usuario \(nameUser) cadastrado com sucesso", pop: true)
                    
                }else{
                    self.showAlertWith(title: "Impossivel cadastrar usuario!", message: "Verifique sua conexão  com a internet \n ou tente novamente mais tarde...")
                }
            }
        }else{
            self.showAlertWith(title: "Atenção!", message: "Senhas não coincidem")
        }
    }
    
    //MARK: - Alert
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert, pop: Bool = false) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            if pop == true{
                self.dismiss(animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }else{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    //MARK: - ScrollView
    @objc func increaseScrollView(_ notification: Notification){
        self.scrollViewRegister.contentSize = CGSize(width: self.scrollViewRegister.frame.width, height: scrollViewRegister.frame.height + self.scrollViewRegister.frame.height / 2)
    }
    
    //MARK: - NavigationBar
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.3058823529, alpha: 1)
    }
}
