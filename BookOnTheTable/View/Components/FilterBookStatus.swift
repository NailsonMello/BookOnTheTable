//
//  FilterBookStatus.swift
//  BookOnTheTable
//
//  Created by administrator on 06/04/21.
//

import Foundation
import UIKit

class FilterBookStatus: NSObject{
    
    func configureFilters() -> UIAlertController{
        let action = UIAlertController(title: "*", message: "Filtrar por status", preferredStyle: .actionSheet)
        
        let done = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        action.addAction(done)
        
        let rect = CGRect(x: 0.0, y: 0.0, width: action.view.frame.width, height: 500)
        action.view.frame = rect
        return action
    }
}
