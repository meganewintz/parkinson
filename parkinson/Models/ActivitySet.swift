//
//  ActivitiesSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications



/// nextActivity
///
/// give the next Activity programed
///
/// - Returns : Activity? (empty if the set is empty))


/// activityOf
///
/// set of activities programed for the day enter in parameter
///
/// - Parameters:
///   - days: `Date`
/// - Returns : 'ActivitiesSet' containing all the activities programed for the day enter


/// checkConflict
///
/// check if the activity enter in paramter doesn't occur in the same time than another actiiviy present in the set
///
/// - Parameters:
///   - activity: `Activity`
/// - Returns : True if there is a conflict




class ActivitySet: Sequence {
    
    fileprivate var pset  : [Activity] = []
    private var delegates : [ActivitySetDelegate]
    private var dao: DAOactivityProtocol?
    
    internal init(dao: DAOactivityProtocol?){
        self.dao = dao
        delegates = [ActivitySetDelegate]()
    }
    
    func initialize(activities: [Activity]){
        self.pset = activities
    }
    

 
    /// addActivity
    ///
    /// `ActivitySet` x `Activity` -> `ActivitySet` -- add Activity to ActivitySet, if `Activity` already belongs to `ActivitySet` then do nothing
    /// - Precondition: An activity with the same name must not exist.
    /// - Parameter activity: `Activity` to be added to the set
    /// - Returns: `ActivitySet` with new `Activity` added to the set, or `ActivitySet` unmodified if `Activity` belonged already to the set.
    @discardableResult
    func addActivity(activity: Activity) -> ActivitySet{
        if !self.contains(where: { $0.name == activity.name }){
            if dao == nil {
                self.pset.append(activity)
                for delegate in delegates {
                    delegate.activityAdded(at: self.count-1)
                }
            } else if(self.dao!.addActivity(patient : Factory.sharedData.patient, activity: activity)){
                self.pset.append(activity)
                for delegate in delegates {
                    delegate.activityAdded(at: self.count-1)
                }
            } else {
                print("Erreur lors de l'ajout de l'activité")
            }
        }
        
        let notif = Notifier(title : "Nouvelle activité", content : activity.name + " a été ajoutée avec succès")
        
        return self
    }
    
    
    /// updateActivity
    ///
    /// replace an activity by another one with different values
    ///
    /// - Parameter old : activity to replace
    /// - Parameter new : activity which will replace
    /// - Returns : 'ActivitySet' with activity replaced if old belonged to the set
    @discardableResult
    func updateActivity(old : Activity, new : Activity) -> ActivitySet {
        if let index = pset.index(where: { $0 === old }){
            if dao == nil {
                pset[index] = new
                for d in delegates {
                    d.activityUpdated(at: index)
                }
            } else if dao!.updateActivity(patient: Factory.sharedData.patient, oldActivity: old, newActivity: new){
                pset[index] = new
                for d in delegates {
                    d.activityUpdated(at: index)
                }
            } else {
                print("Error on updating activity")
            }
        }
        return self
    }
    

    /// removeActivity
    ///
    /// - Parameter activity: `Activity` to be removed
    /// - Returns: `ActivitySet` with `Activity` removed if `Activity` belonged to `ActivitySet`
    @discardableResult
    func removeActivity(activity: Activity) -> ActivitySet{
        if let index = pset.index(where: { $0 === activity }) {
            if dao == nil {
                self.pset.remove(at: index)
                for d in delegates {
                    d.activityRemoved(at: index)
                }
            } else if(self.dao!.removeActivity(patient : Factory.sharedData.patient, activity: activity)){
                self.pset.remove(at: index)
                for d in delegates {
                    d.activityRemoved(at: index)
                }
            }
        }
        return self
    }
    

    /// removeActivity
    ///
    /// `Int` x `Activity` -> `ActivitySet` -- if `Activity` belongs to `ActivitySet`, remove it from the set, else do nothing
    ///
    /// - Parameter activity: `Activity` to be removed
    /// - Returns: `ActivitySet` with `Activity` removed at index
    @discardableResult
    func removeActivity(at index: Int) -> ActivitySet{
        if (index < self.count) {
            if dao == nil {
                self.pset.remove(at: index)
                for d in delegates {
                    d.activityRemoved(at: index)
                }
            } else if(self.dao!.removeActivity(patient : Factory.sharedData.patient, activity: pset[index])){
                self.pset.remove(at: index)
                for d in delegates {
                    d.activityRemoved(at: index)
                }
            }
        }
        return self
    }
    
    /// count
    ///
    /// number of elements in the set
    var count: Int{
        return self.pset.count
    }
    
    /// contains
    ///
    /// `ActivitySet` x `Activity` -> `Bool` -- look for `Activity` in the set...
    ///
    /// - Parameter activity: `Activity` to be looked for
    /// - Returns: True if `Activity` belongs to the set
    func contains(activity: Activity) -> Bool{
        return self.pset.contains(where: {$0===activity})
    }
    
   
    /// contains
    ///
    /// ActivitySet` x `String` -> `Bool` -- look for `Activity` with firstname
    ///
    /// - Parameter firstname: `String` name to be search
    /// - Returns: True if one `Activity` has this firstname
    func contains(activityName name: String) -> Bool{
        return self.pset.contains(where: {$0.name==name})
    }
    
    /// addDelegate
    ///
    /// add a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `TreatmentSetDelegate`
    ///
    /// Returns : 'TreatmentSet' the current instance with the delegate in parameter
    @discardableResult
    func addDelegate(delegate : ActivitySetDelegate) -> ActivitySet {
        if !delegates.contains(where: { $0 === delegate }) {
            delegates.append(delegate)
        }
        return self
    }
    
    
    /// removeDelegate
    ///
    /// remove a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `TreatmentSetDelegate`
    ///
    /// Returns : 'TreatmentSet' the current instance without the delegate in parameter
    @discardableResult
    func removeDelegate(delegate : ActivitySetDelegate) -> ActivitySet {
        if let index = delegates.index(where: { $0 === delegate }) {
            delegates.remove(at: index)
        }
        return self
    }
    
    
    /// nextActivity
    ///
    /// Returns : 'Activity?' the next activity programmed
    func nextActivity() -> Activity? {
        var futureActivities = [Activity]()
        let currentDate = Date()
        for activity in pset {
            if activity.dateNextPractice() > currentDate {
                futureActivities.append(activity)
            }
        }
        return futureActivities.min(by : { $0.dateNextPractice() < $1.dateNextPractice() })
    }

    
    subscript(index: Int) -> Activity {
        get {
            guard (index>=0) && (index<self.count) else{
                fatalError("index out of range")
            }
            return self.pset[index]
        }
        set(newValue) {
            guard (index>=0) && (index<self.count) else{
                fatalError("index out of range")
            }
            self.pset[index]=newValue
        }
    }
    
    /// `ActivitySet` -> `ItActivitySet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItActivitySet{
        return ItActivitySet(self)
    }
    
    
}

// MARK: - Iterator -

/// Iterator on ActivitySet
struct ItActivitySet : IteratorProtocol{
    private var current: Int = 0
    private let set: ActivitySet
    
    fileprivate init(_ s: ActivitySet){
        self.set = s
    }
    
    /// reset iterator
    ///
    /// - Returns: iterator reseted
    @discardableResult
    mutating func reset() -> ItActivitySet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Activity? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextActivity = self.set.pset[self.current]
        self.current += 1
        return nextActivity
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}


