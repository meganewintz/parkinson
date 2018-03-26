//
//  CoreDataManager.swift
//  parkinson
//
//  Created by Thierry WINTZ on 19/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
// = {


import CoreData
import UIKit

class CoreDataManager: NSObject {
    
    
    /// get context from application
    ///
    /// - Returns : 'NSManagedObjectContext' of core data initialized in application delegate
    static var context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            exit(EXIT_FAILURE)
        }
        return appDelegate.persistentContainer.viewContext
    }()
    
    @discardableResult 
    class func save() -> NSError? {
        //try to save it
        do {
            try CoreDataManager.context.save()
            return nil
        }
        catch let error as NSError {
            print("Error during the saving")
            return error
        }
    }
}
