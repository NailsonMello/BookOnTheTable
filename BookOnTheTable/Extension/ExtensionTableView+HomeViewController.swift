//
//  ExtensionTableView+HomeViewController.swift
//  BookOnTheTable
//
//  Created by administrator on 08/04/21.
//

import UIKit

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = statusArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath){
            if(cell.accessoryType == .checkmark){
                cell.accessoryType = .none

                if(statusArray[indexPath.row] == "Lendo"){
                    stackViewReading.isHidden = false
                    
                }else if(statusArray[indexPath.row] == "Para ler"){
                    stackViewToRead.isHidden = false
                }else{
                    stackViewAlreadyRead.isHidden = false
                }
            }else{
                cell.accessoryType = .checkmark
                if(statusArray[indexPath.row] == "Lendo"){
                    stackViewReading.isHidden = true
                    self.view.layoutIfNeeded()
                }else if(statusArray[indexPath.row] == "Para ler"){
                    stackViewToRead.isHidden = true
                    self.view.layoutIfNeeded()
                }else{
                    stackViewAlreadyRead.isHidden = true
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
