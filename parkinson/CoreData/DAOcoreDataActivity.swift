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

    let context = CoreDataManager.context
    let request : NSFetchRequest<ActivityData> = ActivityData.fetchRequest()
    let dtoFrequencyData = DTOcoreDataFrequency()
    
    func save(){
        CoreDataManager.save()
    }
    
    // MARK: - Methods from DAOactivityProtocol
    
    /// get the activities from the CoreData
    ///
    /// - Returns: [Acivity] containing all the activities relaatif to a patient
    func getActivities(patient : Patient) -> [Activity]? {
        
        // Get context
        let context = CoreDataManager.context
        
        // Add predicate, to get activities relative to the patient
        //self.request.predicate = NSPredicate(format: "patient.firstname == %@", patient.firstname)

        let activities: [ActivityData]
        var activitySet = [Activity]()

        // Execute Request
        do {
            try activities = context.fetch(self.request)
            var activityFrequencies: [Event]
            for a in activities{
                activityFrequencies = getFrequencies(patient: patient, activity: a)

                activitySet.append(Activity(name: a.name!, description: a.descr!, frequencies: activityFrequencies))
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
    func getActivity(patient : Patient, name: String) -> Activity? {
     
        // Add Predicate
        let predicate = NSPredicate(format: "type?.name == %@", name) // !!!!! Verif avec le nom en majuscule !!!!!!
        self.request.predicate = predicate
        
        // Execute Request
        do {
            let result = try CoreDataManager.context.fetch(request)
            
            guard result.count != 0 else { return nil }
            let activityData = result[0]
            let activityFrequencies = getFrequencies(patient: patient, activity: activityData)
            return Activity(name: activityData.name!, description: activityData.descr!, frequencies: activityFrequencies)
        }
        catch let error as NSError {
            print (error, error.userInfo)
            return nil
        }
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
        
        // Execute Request
        do {
           let result = try context.fetch(request)
            guard result.count != 0 else {
                return nil
            }
            return result[0]
        }
        catch let error as NSError {
            print (error, error.userInfo)
            return nil
        }
    }
    
    /// Add an activity in the CoreData
    ///
    /// - Parameter patient
    /// - Parameter activity
    /// - Returns: true, if the activity was successfully add in the CoreData - false, if here is already an activity with the same name for this patient
    func addActivity(patient : Patient, activity: Activity) -> Bool {
        
        // Case 1: activity name already exist in CoreData for this patient
        if getActivityData(name: activity.name) != nil {
            return false
        }
        // Case 2: activity name doesn't exist, we need to create it.
        else {
            let activityData = ActivityData(context: CoreDataManager.context)
            activityData.name = activity.name
            activityData.descr = activity.description
            
            for freq in activity.frequencies {
                var frequencyData: FrequencyData?
                // if the frequency already exist in coreData
                frequencyData = dtoFrequencyData.search(day: freq.title, hour: freq.time)
                if frequencyData != nil {
                    activityData.frequencies?.adding(frequencyData!)
                }
                    
                // if the frequency doesn't exist, we need to create it.
                else {
                    frequencyData = FrequencyData(context: context)
                    frequencyData!.day = freq.title
                    frequencyData!.hour = freq.time
                    activityData.frequencies?.adding(frequencyData!)
                }
            }
            self.save()
            return true
        }
    }

    
    /// Remove the activity from ActivityData and return true if the remove success
    ///
    /// - Parameter activity: activity to remove
    /// - Returns: true if the activity was successfully removed, false if the activity enter doesn't exist for this patient.
    func removeActivity(patient : Patient, activity: Activity) -> Bool {
        
        // Get the ActivityData
        let activityToRemove = getActivityData(name: activity.name)
        
        if activityToRemove == nil {
            return false
        }
        
        // Delete the activity from ActivityData
        CoreDataManager.context.delete(activityToRemove!)
        self.save()
        return true
    }
    
    // Voir si on ne fait pas un update par attribut ?
    func updateActivity(patient : Patient, oldActivity: Activity, newActivity: Activity) -> Bool {
        
        let oldActivityData = getActivityData(name: oldActivity.name)
        oldActivityData?.descr = newActivity.description
        self.save()
        return true
    }
    
    
    
    // MARK: - Others -
    
    /// getFrequencies
    ///
    /// Frequencies relative to an activity of a patient
    ///
    /// - Parameters:
    ///   - patient
    ///   - activity
    /// - Returns: [Event] corresponding to the frequencies relative to the patient's activity
    func getFrequencies(patient: Patient, activity: ActivityData) -> [Event] {
        
        var frequencies = [Event]()
        var freqData = activity.frequencies!.allObjects // array [Any]
        var freq: FrequencyData
        if freqData.count-1 > 1 {
            for i in 0...freqData.count-1{
                freq = freqData[i] as! FrequencyData //cast any to FrequencyData
                frequencies.append(Event(title: freq.day!, time: freq.hour!))
            }
        }
        return frequencies
    }

}

