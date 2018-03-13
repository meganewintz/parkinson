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
    
    
    /// init
    ///
    /// initialize an 'TreatmentSet', empty.
    ///
    init(){
        treatments = [Treatment]()
        delegates = [TreatmentSetDelegate]()
    }

    
    /// addTreatment
    ///
    /// add a treatment to the set
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : 'TreatmentSet' with the treatment enter in parameter
    public func addTreatment(treatment : Treatment) -> TreatmentSet {
        treatments.append(treatment)
        for d in delegates {
            d.treatmentAddded(treatment : treatment)
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
    public func removeTreatment(treatment : Treatment) -> TreatmentSet {
        if let index = treatments.index(where: { treatment === $0 }) {
            
        }
        return self
    }
    
    
    /// count
    ///
    /// number of `Treatment` in the set
    ///
    /// - Returns : 'Int'
    
    
    /// contains
    ///
    ///
    /// - Parameters:
    ///   - treatment: `Treatment`
    /// - Returns : True if the treatment is in the set
    
    
    /// nextTreatments
    ///
    /// give the next treatments programed (many treatments if they occurs at the same time)
    ///
    /// - Returns : TreatmentSet
    
    
    /// updateTreatment
    ///
    /// updates a treatment with a new value
    ///
    /// - Parameters:
    ///   - old: `Treatment`
    ///   - new: Treatment
    /// - Returns : 'TreatmentSet' with the treatment updated
    
    
    /// addDelegate
    ///
    /// add a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `TreatmentSetDelegate`
    ///
    /// Returns : 'TreatmentSet' the current instance with the delegate in parameter
    
    
    /// removeDelegate
    ///
    /// remove a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `TreatmentSetDelegate`
    ///
    /// Returns : 'TreatmentSet' the current instance without the delegate in parameter
}
