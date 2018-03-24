//
//  TreatmentSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class TreatmentSet {

    private var treatments : [Treatment]
    private var delegates : [TreatmentSetDelegate]
    private var dao : DAOtreatmentProtocol
    
    
    /// init
    ///
    /// initialize an 'TreatmentSet', empty.
    ///
    internal init(dao: DAOtreatmentProtocol){
        self.dao = dao
        self.treatments = [Treatment]()
        self.delegates = [TreatmentSetDelegate]()
        
    }

    
    /// addTreatment
    ///
    /// add a treatment to the set
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : 'TreatmentSet' with the treatment enter in parameter
    @discardableResult
    public func addTreatment(treatment : Treatment) -> TreatmentSet {
        if dao.addTreatment(patient : Factory.sharedData.patient, treatment : treatment){
            treatments.append(treatment)
            for d in delegates {
                d.treatmentAdded(at : self.count-1)
            }
        } else {
            for d in delegates {
                d.errorDataBaseWrite()
            }
        }
        return self
    }
    
    
    /// removeTreatment
    ///
    /// remove a treatment to the set
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : 'TreatmentSet' without the treatment enter in parameter
    @discardableResult
    public func removeTreatment(treatment : Treatment) -> TreatmentSet {
        if let index = treatments.index(where: { treatment === $0 }) {
            if dao.removeTreatment(patient : Factory.sharedData.patient, treatment : treatment) {
                treatments.remove(at : index)
                for d in delegates {
                    d.treatmentRemoved(at : index)
                }
            } else {
                for d in delegates {
                    d.errorDataBaseWrite()
                }
            }
        }
        return self
    }
    
    
    /// count
    ///
    /// number of `Treatment` in the set
    ///
    /// - Returns : 'Int'
    public var count : Int {
        return treatments.count
    }
    
    
    /// contains
    ///
    /// Indicate if the treatments set contains the specified treatment
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : True if the treatment is in the set
    func contains(treatment : Treatment) -> Bool {
        return treatments.contains(where: { $0 === treatment })
    }
    
    
    
    /// nextTreatments
    ///
    /// give the next treatments programed (many treatments if they occurs at the same time)
    ///
    /// - Returns : [Treatment]
    func nextTreatments() -> [Treatment] {
        var futureTreatments = [Treatment]()
        let currentDate = Date()
        for t in treatments {
            if let date = t.dateNextTreatment() {
                if date > currentDate {
                    futureTreatments.append(t)
                }
            }
        }
        
        var nextTreatments = [Treatment]()
        
        if !futureTreatments.isEmpty {
            var nearestDate : Date = futureTreatments[0].dateNextTreatment()!
            
            for t in futureTreatments {
                if t.dateNextTreatment() == nearestDate {
                    nextTreatments.append(t)
                } else if t.dateNextTreatment()! < nearestDate {
                    nextTreatments.removeAll()
                    nextTreatments.append(t)
                    nearestDate = t.dateNextTreatment()!
                }
            }
        }
        
        return nextTreatments
    }
    
    
    /// updateTreatment
    ///
    /// updates a treatment with a new value
    ///
    /// - Parameters:
    ///   - old: `Treatment`
    ///   - new: Treatment
    /// - Returns : 'TreatmentSet' with the treatment updated
    @discardableResult
    func updateTreatment(old : Treatment, new : Treatment) -> TreatmentSet {
        if let index = treatments.index(where: { $0 === old }) {
            if dao.updateTreatment(patient : Factory.sharedData.patient, old : old, new : new) {
                treatments[index] = new
                for d in delegates {
                    d.treatmentUpdated(at : index)
                }
            } else {
                for d in delegates {
                    d.errorDataBaseWrite()
                }
            }
        }
        return self
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
    func addDelegate(delegate : TreatmentSetDelegate) -> TreatmentSet {
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
    func removeDelegate(delegate : TreatmentSetDelegate) -> TreatmentSet {
        if let index = delegates.index(where: { $0 === delegate }) {
            delegates.remove(at: index)
        }
        return self
    }
}
