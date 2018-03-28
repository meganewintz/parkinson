//
//  Evaluation.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 27/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Evaluation {

/// Evaluation type
/// Contains all the state for an evaluation before neurologue's appointment (the evaluation last for 5 days).
///

    public var appointment : Appointment
    public var morningHour : Date
    public var eveningHour : Date
    private var states : [State]


/// init
///
/// initialize an 'Evaluation'. Create all the dose associate to this evaluation.
///
/// - Parameters:
///   - appointment: `Appointment` first name of `Person`
///   - morningHour:  `Date` reveille of the 'Patient'
///   - eveningHour: `Date` bedtime of the 'Patient'
///   - frequency : the time interval in hour between each query
    private init(appointment : Appointment, morningHour : Date, eveningHour : Date, frequency : Int) {
        self.appointment = appointment
        self.morningHour = morningHour
        self.eveningHour = eveningHour
        states = [State]()
        createStates(frequency: frequency)
    }


/// createStates
///
/// create all the states necessary for this evaluation according to the frequency.
///
/// - Parameters:
///   - frequency: `Int` the frequency that the state need to be evaluate
    private func createStates(frequency : Int) {
        let morning = Calendar.current.component(.hour, from: morningHour)
        let evening = Calendar.current.component(.hour, from: eveningHour)
        let count = (evening - morning + 1) * 5
        var date = beginDate
        for _ : Int in 0..<count {
            states.append(State(date : date))
            date = Calendar.current.date(byAdding: DateComponents(hour : 1), to: date)!
            if Calendar.current.component(.hour, from: date) > evening {
                date = Calendar.current.nextDate(after: date, matching: DateComponents(hour : morning), matchingPolicy: .nextTime)!
            }
        }
    }


/// count
///
/// number of `State` in the collection
///
/// - Returns : 'Int' number of 'State' in the 'Evaluation'
    public var count : Int {
        return states.count
    }


/// getBeginDate
///
/// give the beggining date of the evaluation
///
/// - Returns : 'Date' the beggining date of the evaluation
    var beginDate : Date {
        let morning = Calendar.current.component(.hour, from: morningHour)
        return Calendar.current.date(bySettingHour: morning, minute: 0, second: 0, of: Calendar.current.date(byAdding: DateComponents(day : -5), to: appointment.date)!)!
    }


/// getStatesEvaluated
///
/// give all the states evalaluted
///
///
/// - Returns : 'Set?' set of 'State' evaluated
    func getEvaluatedStates() -> [State] {
        return states.filter({ $0.state != nil })
    }


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
    func getState(at index : Int) -> State {
        guard index>0 && index<states.count else { fatalError("Index out of range in states") }
        return states[index]
    }
    
    
    /// indicates if the evaluation is active or not
    var isActive : Bool {
        return Date() > beginDate && Date() < appointment.date
    }
    
    
    /// set the state to the current State element (the last where state is not indicated)
    func setState(state : TypeOfState) -> Evaluation {
        if let element = states.filter({ $0.state == nil }).min(by: { $0.date < $1.date }){
            element.state = state
        }
        return self
    }
    
    
    /// - Returns : the date of the next state query if it exists
    var dateNextQuery : Date? {
        return states.filter({ $0.state != nil }).min(by: { $0.date < $1.date })?.date
    }
}

