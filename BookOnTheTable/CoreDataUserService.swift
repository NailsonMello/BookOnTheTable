//
//  CoreDataUserService.swift
//  BookOnTheTable
//
//  Created by administrator on 07/04/21.
//

import UIKit
import CoreData

class CoreDataUserService: NSObject {
    private override init(){}
    static let shared = CoreDataUserService()
    
    var result: NSFetchedResultsController<TokenUser>?
    var context: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveToken(_ token: String){
        deleteToken("TokenUser")
        var tokenUser: NSManagedObject?
       
        let entity = NSEntityDescription.entity(forEntityName: "TokenUser", in: context)
        tokenUser = NSManagedObject(entity: entity!, insertInto: context)
        
        tokenUser?.setValue(token, forKey: "token")
        updateContext()
        
    }
    
    func getToken() -> String{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TokenUser")
        fetchRequest.returnsObjectsAsFaults = false
        var token: String = ""
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                token = (results[0] as AnyObject).value(forKey: "token") as! String
            }

        } catch {
            print(error.localizedDescription)
        }
        
        return token
    }

     func deleteToken(_ entity: String) {
        let fetchRequest = NSFetchRequest<TokenUser>(entityName: entity)
        do {
            let objects = try context.fetch(fetchRequest)
            _ = objects.map({context.delete($0)})
            
            updateContext()
        } catch {
            print("Deleting Error: \(error)")
        }
     }
    
    func updateContext() {
        do {
            try context.save()
        } catch  {
            print(error.localizedDescription)
        }
    }
}
