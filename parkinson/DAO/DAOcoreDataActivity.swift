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

    
    // MARK: - Methods from DAOactivityProtocol
    
    /// get the activities from the CoreData
    ///
    /// - Returns: AcivitySet containing all the activities
    func getActivities() -> ActivitySet? {
        
        // Get context
        let context = CoreDataManager.context
        
        let activities: [ActivityData]
        let activitySet: ActivitySet = ActivitySet(dao: self)

        // Create Fetch Request
        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()

        // Execute Request
        do {
            try activities = context.fetch(request)
            for a in activities{
                //activitySet.addActivity(activity: Activity(name: "Hello", description: a.descr!))
                activitySet.addActivity(activity: Activity(name: (a.type?.name!)!, description: a.descr!))
            }
        }
        catch let error as NSError {
            print (error, error.userInfo)
            return nil
        }
        return activitySet
    }
    
    
    
    
    /// Give an activity from the CoreData with a specific name and return an Activity
    ///
    /// - Parameter name: name of the activity
    /// - Returns: Activity or nil if no activity correspond to the name
    func getActivity(name: String) -> Activity? {
        
        // Get context
        let context = CoreDataManager.context

        // Create Fetch Request
        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()

        // Add Predicate
        let predicate = NSPredicate(format: "type?.name == %@", name) // !!!!! Verif avec le nom en majuscule !!!!!!
        request.predicate = predicate
        var activityData: ActivityData? = nil
        
        // Execute Request
        do {
            activityData = try context.fetch(request)[0]
        }
        catch let error as NSError {
            print (error, error.userInfo)
        }
        guard activityData != nil else {
            return nil
        }
        return Activity(name: (activityData?.type?.name)!, description: (activityData?.descr)!)
    }
    
    /// Give an activity from the CoreData with a specific name and return an ActivityData
    ///
    /// - Parameter name: name of the activity
    /// - Returns: ActivityData or nil if no activity correspond to the name
    func getActivityData(name: String) -> ActivityData? {

        // Get context
        let context = CoreDataManager.context

        // Create Fetch Request
        let request: NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
        //let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ActivityData")

        // Add Predicate
        let predicate = NSPredicate(format: "name == %@", name)
        request.predicate = predicate
        
        var activityData: ActivityData? = nil

        // Execute Request
        do {
            activityData = try context.fetch(request)[0]
        }
        catch let error as NSError {
            print (error, error.userInfo)
        }
        guard activityData != nil else {
            return nil
        }
        return activityData
    }
    
    /// Add an activity in the CoreData
    ///
    /// - Parameter activity
    /// - Returns: true if the activity was successfully add in the CoreData
    func addActivity(activity: Activity) -> Bool {
        
        // Get context
        let context = CoreDataManager.context

        let activityData = ActivityData(context: context)
        activityData.descr = activity.description
        let activitiesTypeData = getActivityType(withName: activity.name)
        
        if (activitiesTypeData.count > 0) {
        // Case 1: activityType already exist in CoreData
            activityData.type = activitiesTypeData[0]
        }
        else {
        // Case 2: activityType doesn't exist, we need to create it.
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

    
    /// Remove the activity from ActivityData and return true if the remove success
    ///
    /// - Parameter activity: activity to remove
    /// - Returns: true if the activity was successfully removed.
    func removeActivity(activity: Activity) -> Bool {

        // Get context
        let context = CoreDataManager.context

        // Get the ActivityData
        let activityToRemove = getActivityData(name: activity.name)
        
        guard activityToRemove != nil else {
            return false
        }
        
        // Delete the activity from ActivityData
        context.delete(activityToRemove!)
        
        do {
            try context.save()
        } catch {
            return false
        }
        return true
    }
    
    func updateActivity(oldActivity: Activity, newActivity: Activity) -> Bool {
        
        // Get context
        let context = CoreDataManager.context
        
        let oldActivityData = getActivityData(name: oldActivity.name)
        oldActivityData?.descr = newActivity.description
        do {
            try context.save()
        }
        catch _ as NSError {
            fatalError("Error saving : addActivity")
        }
        return true
    }
    
    // MARK: - Others -
    
    
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

}

