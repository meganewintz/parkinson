//
//  TreatmentSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class TreatmentSet: Sequence {

    fileprivate var pset : [Treatment]
    private var delegates : [TreatmentSetDelegate]
    private var dao : DAOtreatmentProtocol?
    
    
    /// init
    ///
    /// initialize an 'TreatmentSet', empty.
    ///
    internal init(dao: DAOtreatmentProtocol){
        self.dao = dao
        self.pset = [Treatment]()
        self.delegates = [TreatmentSetDelegate]()
        
    }
    
    func initialize(treatments: [Treatment]){
        self.pset = treatments
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
        if !self.contains(treatment: treatment){
            if dao == nil {
                self.pset.append(treatment)
                for delegate in delegates {
                    delegate.treatmentAdded(at: self.count-1)
                }
            } else if(self.dao!.addTreatment(patient : Factory.sharedData.patient, treatment: treatment)){
                self.pset.append(treatment)
                for delegate in delegates {
                    delegate.treatmentAdded(at: self.count-1)
                }
            } else {
                print("Erreur lors de l'ajout de l'activité")
                for d in delegates {
                    d.errorDataBaseWrite()
                }
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
        if let index = pset.index(where: { $0 === treatment }) {
            if dao == nil {
                self.pset.remove(at: index)
                for d in delegates {
                    d.treatmentRemoved(at: index)
                }
            } else if self.dao!.removeTreatment(patient: Factory.sharedData.patient, treatment: treatment){
                self.pset.remove(at: index)
                for d in delegates {
                    d.treatmentRemoved(at: index)
                }
            }
        }
        return self
    }
    
    /// removeTreatment
    ///
    /// remove a treatment to the set
    ///
    /// - Parameters:
    ///   - at: index of the treatment that we want to remove
    /// - Returns : 'TreatmentSet' without the treatment enter in parameter
    @discardableResult
    public func removeTreatment(at index: Int) -> TreatmentSet {
        if (index < self.count) {
            if dao == nil {
                self.pset.remove(at: index)
                for d in delegates {
                    d.treatmentRemoved(at: index)
                }
            } else if(self.dao?.removeTreatment(patient : Factory.sharedData.patient, treatment: pset[index]))!{
                self.pset.remove(at: index)
                for d in delegates {
                    d.treatmentRemoved(at: index)
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
        return pset.count
    }
    
    
    /// contains
    ///
    /// Indicate if the treatments set contains the specified treatment
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : True if the treatment is in the set
    func contains(treatment : Treatment) -> Bool {
        return pset.contains(where: { $0 === treatment })
    }
    
    
    
    /// nextTreatments
    ///
    /// give the next treatments programed (many treatments if they occurs at the same time)
    ///
    /// - Returns : [Treatment]
    func nextTreatments() -> [Treatment] {
        var futureTreatments = [Treatment]()
        let currentDate = Date()
        for t in pset {
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
        if let index = pset.index(where: { $0 === old }){
            if dao == nil {
                pset[index] = new
                for d in delegates {
                    d.treatmentUpdated(at: index)
                }
            } else if dao!.updateTreatment(patient: Factory.sharedData.patient, old: old, new: new){
                pset[index] = new
                for d in delegates {
                    d.treatmentUpdated(at: index)
                }
            } else {
                print("Error on updating activity")
            }
        }
        return self
    }
    
    
    /// <#Description#>
    ///
    /// - Parameter name: <#name description#>
    /// - Returns: <#return value description#>
    func getTreatment(drugName name: String) -> Treatment?{
        guard let treatment = self.pset.first(where: {$0.name==name}) else {
            return nil
        }
        return treatment
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
    
    subscript(index: Int) -> Treatment {
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
    
    /// `TreatmentSet` -> `ItTreatmentSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItTreatmentSet{
        return ItTreatmentSet(self)
    }
    
    
}

// MARK: - Iterator -

/// Iterator on TreatmentSet
struct ItTreatmentSet : IteratorProtocol{
    private var current: Int = 0
    private let set: TreatmentSet
    
    fileprivate init(_ s: TreatmentSet){
        self.set = s
    }
    
    /// reset iterator
    ///
    /// - Returns: iterator reseted
    @discardableResult
    mutating func reset() -> ItTreatmentSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Treatment? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextTreatment = self.set.pset[self.current]
        self.current += 1
        return nextTreatment
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
