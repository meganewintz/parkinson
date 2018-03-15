//
//  DoseSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DoseSet {
    
    var doses : [Dose]
    var delegates : [DoseSetDelegate]
    
    
    /// init
    ///
    /// initialize an 'DoseSet', empty.
    ///
    init(){
        doses = [Dose]()
        delegates = [DoseSetDelegate]()
    }
    
    
    /// addDose
    ///
    /// add a dose to the set
    ///
    /// - Parameters:
    ///   - dose: `Dose`
    /// - Returns : 'DoseSet' with the dose enter in parameter
    @discardableResult
    func addDose(dose : Dose) -> DoseSet {
        doses.append(dose)
        for d in delegates {
            d.doseAdded(dose : dose)
        }
        return self
    }
    
    
    /// count
    ///
    /// number of `Dose` in the set
    ///
    /// - Returns : 'Int'
    public var count : Int {
        return doses.count
    }
    
    
    /// contains
    ///
    ///
    /// - Parameters:
    ///   - dose: `Dose`
    /// - Returns : True if the dose is in the set
    func contains(dose : Dose) -> Bool {
        return doses.contains(where : { $0 === dose })
    }
    
    
    /// nextReminder
    ///
    /// give the next dose reminder
    ///
    /// - Returns : Dose? (nil if there is no reminder programmed)
    func nextReminder() -> Dose? {
        guard doses.count > 0 else { return nil }
        
        // get only the future doses
        let currentDate = Date()
        var futureDoses = [Dose]()
        for dose in doses {
            if let date = dose.dateNextReminder() {
                if date > currentDate {
                    futureDoses.append(dose)
                }
            }
        }
        
        if futureDoses.count == 0 {
            // no future dose to take
            return nil
        } else {
            // find the dose which minimise the time interval between its date and the current date
            var nearestDose = futureDoses[0]
            var smallestInterval = nearestDose.dateNextReminder()!.timeIntervalSince(currentDate)
            for dose in futureDoses {
                if dose.dateNextReminder()!.timeIntervalSince(currentDate) < smallestInterval {
                    smallestInterval = dose.dateNextReminder()!.timeIntervalSince(currentDate)
                    nearestDose = dose
                }
            }
            return nearestDose
        }
    }
    
    
    /// updateDose
    ///
    /// updates a dose with a new value
    ///
    /// - Parameters:
    ///   - old: `Dose`
    ///   - new: Dose
    /// - Returns : 'DoseSet' with the dose updated
    @discardableResult
    func updateDose(old : Dose, new : Dose) -> DoseSet {
        if let index=doses.index(where : { $0 === old }) {
            doses[index] = new
            for d in delegates {
                d.doseUpdated(newValue : new)
            }
        }
        return self
    }
    
    
    /// addDelegate
    ///
    /// add a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `DoseSetDelegate`
    ///
    /// Returns : 'DoseSet' the current instance with the delegate in parameter
    @discardableResult
    func addDelegate(delegate : DoseSetDelegate) -> DoseSet {
        if !delegates.contains(where : { $0 === delegate }) {
            delegates.append(delegate)
        }
        return self
    }
    
    
    /// removeDelegate
    ///
    /// remove a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `DoseSetDelegate`
    ///
    /// Returns : 'DoseSet' the current instance without the delegate in parameter
    @discardableResult
    func removeDelegate(delegate : DoseSetDelegate) -> DoseSet {
        if let index = delegates.index(where : { $0 === delegate }) {
            delegates.remove(at : index)
        }
        return self
    }
    
    
    /// percentageOfSuccess
    ///
    /// return the percentage of taken doses of the number of programmed doses
    ///
    /// Return : Float
    func percentageOfSuccess() -> Float {
        var success : Int = 0
        for dose in doses {
            if dose.isTaken {
                success += 1
            }
        }
        return Float(success) / Float(self.count) * 100
    }
}

