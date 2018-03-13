//
//  Evaluation.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 27/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

/// Evaluation type
/// Contains all the state for an evaluation before neurologue's appointment (the evaluation last for 5 days).
///

/// ---- Proprieties
///
/// appointment : Appointment
///
/// morningHour
///
/// eveningHour

/// ---- Methods
///

/// init
///
/// initialize an 'Evaluation'. Create all the dose associate to this evaluation.
///
/// - Parameters:
///   - appointment: `Appointment` first name of `Person`
///   - morningHour:  `Date` reveille of the 'Patient'
///   - eveningHour: `Date` bedtime of the 'Patient'


/// createStates
///
/// create all the states necessary for this evaluation according to the frequency.
///
/// - Parameters:
///   - frequency: `Int` the frequency that the state need to be evaluate
/// - Returns : 'Evaluation' with all his 'State' initializate


/// count
///
/// number of `State` in the collection
///
/// - Returns : 'Int' number of 'State' in the 'Evaluation'


/// getBeginDate
///
/// give the beggining date of the evaluation
///
/// - Returns : 'Date' the beggining date of the evaluation


/// getStatesEvaluated
///
/// give all the states evalaluted
///
///
/// - Returns : 'Set?' set of 'State' evaluated


/// makeIterator
///
/// make an iterator on the set
///
/// - Returns: a new iterator on the set initialized on the first element


/// getState
///
/// give the state corresponding to the index enter in parameter
///
/// - Parameters:
///   - index: `Int`
/// - Returns : 'State' the state correspondind to the index

//
//class Evaluation: Sequence {
//
//}

