//
//  DAOActivityData.swift
//  parkinson
//
//  Created by Thierry WINTZ on 13/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DAOcoreDataActivity : DAOactivityProtocol{
    func getActivities() -> ActivitySet? {
        var toto: ActivityData
        return nil
    }
    
    func getActivity(name: String) -> Activity? {
        return nil
    }
    
    func addActivity(activity: Activity) -> Bool {
        return true
    }
    
    func removeActivity(activity: Activity) -> Bool {
        return true
    }
    
    func updateActivity(oldActivity: Activity, newActivity: Activity) -> Bool {
        return true
    }
    

//    func getActivities() -> ActivitySet? {
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            fatalError("can't get appDelegate")
//        }
//        
//        let context = appDelegate.persistentContainer.viewContext
//        let activities: [ActivityData]
//        let activitySet: ActivitySet = ActivitySet(dao: self)
//        
//        // request to take the activities from the CoreData
//        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
//        
//        do {
//            try activities = context.fetch(request)
//            var activity: Activity
//            for a in activities{
//                activity = Activity(name: "Natation", description: a.descr!)
//                //activity = Activity(name: a.name!, description: a.descr!)
//                activitySet.addActivity(activity: activity)
//            }
//        }
//        catch let error as NSError {
//            print (error, error.userInfo)
//            return nil
//        }
//        return activitySet
//    }
//    
//    
//    func getActivity(name: String) -> Activity? {
//        
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
////            return nil
////        }
////        let context = appDelegate.persistentContainer.viewContext
////
////        // Create Fetch Request
////        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
////        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
////
////        // Add Predicate
////        let predicate = NSPredicate(format: "name == %@", name)
////        request.predicate = predicate
////        var activityData: ActivityData? = nil
////        do {
////            activityData = try context.fetch(request)[0]
////
////        }
////        catch let error as NSError {
////            print (error, error.userInfo)
////        }
////        guard activityData != nil else {
////            return nil
////        }
////        return activity
//        return nil
//    }
//    
//    func getActivity(name: String) -> ActivityData? {
//        
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return nil
//        }
//        let context = appDelegate.persistentContainer.viewContext
//
//        // Create Fetch Request
//        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
//        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")
//
//        // Add Predicate
//        let predicate = NSPredicate(format: "name == %@", name)
//        request.predicate = predicate
//        var activityData: ActivityData? = nil
//        do {
//            activityData = try context.fetch(request)[0]
//
//        }
//        catch let error as NSError {
//            print (error, error.userInfo)
//        }
//        guard activityData != nil else {
//            return nil
//        }
//        return activityData
//    }
//    
//    
//    func addActivity(activity: Activity) -> Bool {
////        // first get context into application delegate
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
////            return false
////        }
////        let context = appDelegate.persistentContainer.viewContext
////
////        let activityData = ActivityData(context: context)
////        //activityData.name = activity.name
////        activityData.descr = activity.description
////
////        do {
////            try context.save()
////        }
////        catch _ as NSError {
////            return false
////        }
////        return true
//        return true
//    }
//    
//    func removeActivity(activity: Activity) -> Bool {
////        //first get context into application delegate
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
////            return false
////        }
////        let context = appDelegate.persistentContainer.viewContext
////
////        let activityToRemove = getActivity(name: activity.name)
////        guard activityToRemove != nil else {
////            return false
////        }
////        context.delete(activityToRemove!)
////        do {
////            try context.save()
////        } catch {
////            return false
////        }
//        return true
//    }
//    
//    func updateActivity(oldActivity: Activity, newActivity: Activity) -> Bool {
//        return true
//    }
//    
//    // MARK: - Utilities -
//    
//    func context()  {
//    }
//    
}

