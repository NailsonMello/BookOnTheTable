//
//  SplashScreenViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 31/03/21.
//

import UIKit

class SplashScreenViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        moveToLoginScreen()
    }

    private func moveToLoginScreen(){
        self.perform(#selector(self.loginScreen))
        //self.showAlertWith(title: "Impossivel conectar!", message: "Verifique sua conexão  com a internet \n ou tente novamente mais tarde...")
    }
    
    // MARK: - Alerta
    func showAlertWith(title: String, message: String, style: UIAlertController.Style = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    @objc func loginScreen() {
        performSegue(withIdentifier: "loginscreen", sender: self)
    }
    
}

