//
//  ForgotPasswordViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 01/04/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet weak var stackForgot: UIStackView!
    @IBOutlet weak var txtEmailForgot: UITextField!    
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StackViewTop().setup(stackForgot)
        
        RoundedButton().setup(btnForgotPassword)
           
        RoundedTextField().setup(txtEmailForgot)
        ImageButton().addLeftImageTo(txtEmailForgot, UIImage(named: "email")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBar() 
    }
    
    //MARK: - NavigationBar
    private func setNavigationBar() {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.backItem?.backButtonTitle = "Voltar"
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.5568627451, blue: 0.3058823529, alpha: 1)
    }
}
