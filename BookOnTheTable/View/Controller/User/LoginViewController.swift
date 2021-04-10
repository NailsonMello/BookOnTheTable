//
//  LoginViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 31/03/21.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var loginUserBtn: UIButton!
    
    @IBOutlet weak var scrollViewLogin: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        StackViewTop().setup(stack)
              
        RoundedButton().setup(loginUserBtn)
        
        RoundedTextField().setup(txtEmail)
        RoundedTextField().setup(txtPassword)
        ImageButton().addLeftImageTo(txtEmail, UIImage(named: "email")!)
        ImageButton().addLeftImageTo(txtPassword, UIImage(named: "key")!)
        
        NotificationCenter.default.addObserver(self, selector: #selector(increaseScrollView(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        let isLogged = UserViewModel.viewModel.loggedUser()
        if isLogged {
            goToHome()
        }
    }
    
        
    //MARK: - Login User
    @IBAction func loginUser(_ sender: UIButton) {
        guard let email = txtEmail.text, let password = txtPassword.text else {return}
        
        let user = LoginUser(email: email, password: password)
        UserViewModel.viewModel.login(user) { (response) in
            if let nameUser = response.token{
                print(nameUser)
                self.goToHome()
            }else{
                self.showAlertWith(title: "Erro ao fazer login!", message: "Verifique seu email e senha e tente novamente")
            }
        }
    }
    
    func goToHome(){
        let home = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(identifier: "homeview") as! HomeViewController
        self.navigationController?.pushViewController(home, animated: true)
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
        self.scrollViewLogin.contentSize = CGSize(width: self.scrollViewLogin.frame.width, height: scrollViewLogin.frame.height + self.scrollViewLogin.frame.height / 2)
    }
}
