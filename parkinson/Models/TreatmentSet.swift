//
//  TreatmentSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

/// TreatmentSet type
///

/// ---- Methods
///

/// init
///
/// initialize an 'TreatmentSet', empty.
///


/// addTreatment
///
/// add a treatment to the set
///
/// - Parameters:
///   - treatment: `Treatment`
/// - Returns : 'TreatmentSet' with the treatment enter in parameter


/// removeTreatment
///
/// remove a treatment to the set
///
/// - Parameters:
///   - treatment: `Treatment`
/// - Returns : 'TreatmentSet' without the treatment enter in parameter


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

class TreatmentSet {
    
}
