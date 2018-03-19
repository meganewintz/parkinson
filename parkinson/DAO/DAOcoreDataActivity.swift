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

    /// give the ActivityTypeData with the name enter in parameter, nul if it not exist
    ///
    /// - Parameter name: name of the activity
    /// - Returns: ActivityTypeData with the name enter in parameter, nil if there is nothing ActivityTypeData corresponding
    func getActivityType(withName name: String) -> [ActivityTypeData] {
        // Get context
        let context = CoreDataManager.context

        // Create Fetch Request
        let request: NSFetchRequest<ActivityTypeData> = ActivityTypeData.fetchRequest()
        
        // Add Predicate
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        // Execute Request
        var activityType: [ActivityTypeData] = []
        do {
            activityType = try context.fetch(request)
            }
        catch let error as NSError {
            print (error, error.userInfo)
            fatalError("Error read ActivityTypeData (isAlreadyExistType method")
        }
        return activityType
    }
    
    /// Add an activity in the CoreData
    ///
    /// - Parameter activity
    /// - Returns: true if the activity was successfully add in the CoreData
    func addActivity(activity: Activity) -> Bool {
        // Get context
        let context = CoreDataManager.context

        // Create Fetch Request
        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
        let predicate = NSPredicate(format: "name == %@", activity.name)
        request.predicate = predicate

        let activityData = ActivityData(context: context)
        activityData.descr = activity.description
        let activitiesTypeData = getActivityType(withName: activity.name)
        
        // if the activityType already exist in CoreData
        if (activitiesTypeData.count > 0) {
            activityData.type = activitiesTypeData[0]
        }
        else {
            let activityTypeData = ActivityTypeData(context: context)
            activityTypeData.name = activity.name
            activityData.type = activityTypeData

        }
        do {
            try context.save()
        }
        catch _ as NSError {
            fatalError("Error saving : addActivity")
        }
        return true
    }

    func getActivities() -> ActivitySet? {
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
        return nil
    }
    
    
    func getActivity(name: String) -> Activity? {
        
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
//        return activity
        return nil
    }
    
    func getActivity(name: String) -> ActivityData? {
        
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
        return nil
    }
    
    
    func removeActivity(activity: Activity) -> Bool {
//        //first get context into application delegate
//        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//            return false
//        }
//        let context = appDelegate.persistentContainer.viewContext
//
//        let activityToRemove = getActivity(name: activity.name)
//        guard activityToRemove != nil else {
//            return false
//        }
//        context.delete(activityToRemove!)
//        do {
//            try context.save()
//        } catch {
//            return false
//        }
        return true
    }
    
    func updateActivity(oldActivity: Activity, newActivity: Activity) -> Bool {
        return true
    }
    
    // MARK: - Utilities -

}

