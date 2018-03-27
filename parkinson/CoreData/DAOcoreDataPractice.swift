//
//  DAOcoreDataPractice.swift
//  parkinson
//
//  Created by Florent BERLAND on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData

class DAOcoreDataPractice : DAOpracticeProtocol {
    
    let context = CoreDataManager.context
    let request : NSFetchRequest<IsDoneActivityData> = IsDoneActivityData.fetchRequest()
    
    func save(){
        CoreDataManager.save()
    }
    
    
    func getPractices(patient: Patient, activity: Activity) -> [Practice]? {
        // Get context
        let context = CoreDataManager.context
        
        // Add predicate, to get activities relative to the patient
        //self.request.predicate = NSPredicate(format: "patient.firstname == %@", patient.firstname)
        
        let practices: [IsDoneActivityData]
        var practiceSet = [Practice]()
        
        // Execute Request
        do {
            try practices = context.fetch(self.request)
            for practice in practices {
                if (practice.activity?.contains(where: { ($0 as! ActivityData).name == activity.name }))!{
                    let prac = Practice()
                    prac.reminderNb = (Int)(practice.remindNumber)
                    prac.isDone = practice.isDone
                    prac.isCancelled = practice.isCancelled
                    let dates = getDates(practice: practice)
                    if dates.count > 0 {
                        prac.dateFirstReminder = dates[0]
                    }
                    practiceSet.append(prac)
                }
            }
        }
        catch let error as NSError {
            print (error, error.userInfo)
            return nil
        }
        return practiceSet
    }
    
    func addPractice(practice: Practice, patient: Patient, activity: Activity) -> Bool {
        
        return false
    }
    
    func updatePractice(old: Practice, new: Practice, patient: Patient, activity: Activity) -> Bool {
        return false
    }
    
    
    func getDates(practice : IsDoneActivityData) -> [Date] {
        let nsDates = practice.dates?.allObjects
        var dates = [Date]()
        if nsDates != nil {
            for d in nsDates! {
                dates.append((d as! DateData).date!)
            }
        }
        return dates
    }
    
}
