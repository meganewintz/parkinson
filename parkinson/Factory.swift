//
//  Factory.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 09/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class Factory {
    
    var activitySet: ActivitySet = ActivitySet()
    var activities: [ActivityData] = []
    
    func initializeData() {
        let a1 : Activity = Activity(name: "Marche à pied", description: "Marche 20km puis s'arrêter 20 min. Reprendre 10min")
        let a2 : Activity = Activity(name: "Natation", description: "400m papillon")
        let a3 : Activity = Activity(name: "Jardinage", description: "Laver 3 pots")
        self.activitySet.addActivity(activity: a1)
        self.activitySet.addActivity(activity: a2)
        self.activitySet.addActivity(activity: a3)

    }
    
    
    func loadActivities() -> [String]? {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let errormsg = "Recupération impossible"
            let userInfo = "Inconnu"
            return [errormsg, userInfo]
        }
        let context = appDelegate.persistentContainer.viewContext
        
        // request to take the activities from the CoreData
        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
        do {
            try self.activities = context.fetch(request)
            var activity: Activity
            for a in self.activities{
                activity = Activity(name: a.name!, description: a.descr!)
                self.activitySet.addActivity(activity: activity)
            }
        }
        catch let error as NSError {
            return ["\(error)", "\(error.userInfo)"]
        }
        return nil
    }
    
    func saveActivity(withName name: String, withDescr descr: String) -> [String]? {
        // first get context into application delegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {

            let errormsg = "Sauvegarde impossible, réessayez plus tard"
            let userInfo = "Inconnu"
            return [errormsg, userInfo]
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let activityData = ActivityData(context: context)
        activityData.name = name
        activityData.descr = descr
        
        do {
            try context.save()
            let activity = Activity(name: name, description: descr)
            self.activitySet.addActivity(activity: activity)
        }
        catch let error as NSError {
            return ["\(error)", "\(error.userInfo)"]
        }
        return nil
    }
    
    
//    func getActivity(activityWithIndex index: Int) -> ActivityData {
//        // first get context into application delegate
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//
//            let errormsg = "Sauvegarde impossible, réessayez plus tard"
//            let userInfo = "Inconnu"
//            return [errormsg, userInfo]
//        }
//        let context = appDelegate.persistentContainer.viewContext
//
//        let activityName = activities[index].name
//
//        // Create Fetch Request
//        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
//        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
//
//        // Add Sort Descriptor
//        //        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
//        //        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        // Add Predicate
//        let predicate = NSPredicate(format: "name == %@", activityName!)
//        request.predicate = predicate
//
//        do {
//            let activity = try context.fetch(request)
//            catch let error as NSError {
//                return ["\(error)", "\(error.userInfo)"]
//            }
//            return activity[0]
//
//    }
    /// Delete an activity
    ///
    /// - Precondition: index must be into bound of collection
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    //func deleteActivity(activityWithIndex index: Int) -> [String]? {
        // first get context into application delegate
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//
//            let errormsg = "Sauvegarde impossible, réessayez plus tard"
//            let userInfo = "Inconnu"
//            return [errormsg, userInfo]
//        }
//        let context = appDelegate.persistentContainer.viewContext
//
//        let activityName = activities[index].name
//
//        // Create Fetch Request
//        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
//        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
//
//        // Add Sort Descriptor
////        let sortDescriptor = NSSortDescriptor(key: "name", ascending: true)
////        fetchRequest.sortDescriptors = [sortDescriptor]
//
//        // Add Predicate
//        let predicate = NSPredicate(format: "name == %@", activityName!)
//        request.predicate = predicate
//
//        do {
//            let activity = try context.fetch(request)
//            catch let error as NSError {
//                return ["\(error)", "\(error.userInfo)"]
//            }
//            return nil
//
//        let activityData = ActivityData(context: context)
//        activityData.name = name
//        activityData.descr = descr
//
//        do {
//            try context.save()
//            let activity = Activity(name: name, description: descr)
//            self.activitySet.addActivity(activity: activity)
//        }
//        catch let error as NSError {
//            return ["\(error)", "\(error.userInfo)"]
//        }
//        return nil
   // }
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "ActivityData",
                                       in: managedContext)!
        
        let activity = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        activity.setValue(name, forKeyPath: "name")
        activity.setValue("OK", forKeyPath: "descr")

        
        // 4
        do {
            try managedContext.save()
            let act = Activity(name: name, description: "ok")
            self.activitySet.addActivity(activity: act)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
//
//    func getContext() {
//        // first get context into application delegate
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//
//            let errormsg = "Sauvegarde impossible, réessayez plus tard"
//            let userInfo = "Inconnu"
//            return [errormsg, userInfo]
//        }
//        return context = appDelegate.persistentContainer.viewContext
//
//    }

}
