//
//  Activity.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Activity {
    
    var name : String
    var description: String
    var frequencies: [Event]
    private var practices : PracticesSet
    
    
    /// init
    ///
    /// initialize an 'Activity' with his name and his description
    ///
    /// - Parameters:
    ///   - name: `String`
    ///   - description:  `String`
    internal init(name : String, description: String) {
        self.name = name
        self.description = description
        self.frequencies = []
        self.practices = PracticesSet()
        if let practArray = Factory.sharedData.daoPractice.getPractices(patient: Factory.sharedData.patient, activity: self) {
            for p in practArray {
                practices.addPractice(practice: p)
            }
        }
    }
    
    /// init
    ///
    /// initialize an 'Activity' with his name and his description
    ///
    /// - Parameters:
    ///   - name: `String`
    ///   - description:  `String`
    ///   - frenquency: [Event] days and hours when the activity must be done.
    init(name : String, description: String, frequencies: [Event]) {
        self.name = name
        self.description = description
        self.frequencies = frequencies
        self.practices = PracticesSet()
        if let practArray = Factory.sharedData.daoPractice.getPractices(patient: Factory.sharedData.patient, activity: self) {
            for p in practArray {
                practices.addPractice(practice: p)
            }
        }
    }
    
    /// dateNextPractice
    ///
    /// give the date of the next practice programed
    ///
    /// - Returns : 'Date' the date of the next practice programed
    func dateNextPractice() -> Date? {
        guard frequencies.count > 0 else { return nil }
        
        let currentDate = Date()
        let calendar = Calendar.current
        let day = calendar.component(.weekday, from: currentDate)
        let hour = calendar.component(.hour, from: currentDate)
        let minute = calendar.component(.minute, from: currentDate)
        /*
         Algo :
            S'il existe un event e le jour même
                Si l'heure de e est inférieure à l'heure même
                    passer à la date suivante
                Si l'heure de e est la même
                    Si la minute de e est inférieure ou égale à la minute même
                        passer à la date suivante
                    Sinon
                        cette date est la bonne
                Sinon
                    cette date est la bonne
            Sinon
                S'il n'y a pas de jour supérieur dans la semaine
                    recommencer la recherche au début de la semaine
                Sinon
                    passer à la date suivante
         
         =====Transformation=====
         
            S'il existe un event e le jour même
                Si l'heure est supérieure
                    cette date est la bonne
                Sinon si l'heure est égale
                    Si la minute est supérieure
                        cette date est la bonne
            Sinon
                S'il n'y a pas de jour supérieur dans la semaine
                    recommencer la recherche au début de la semaine
                Sinon
                    passer à la date suivante
         
        =====Transformation=====
         
            date de recherche = date du jour
            S'il existe un event e le jour même
                Si l'heure est supérieure
                    cette date est la bonne : date de recherche = date de l'event (convertie en date absolue)
                Sinon si l'heure est égale
                    Si la minute est supérieure
                        cette date est la bonne : date de recherche = date de l'event (convertie en date absolue)
            Si la date a été trouvée
                retourner la date
            Sinon
                Si la date de recherche est la plus avancée dans la semaine
                    date de l'event = plus petite date de la semaine (en date absolue)
                Sinon
                    date de l'event = date suivante (en date absolue)
         */
        
        var nextDate : Date?
        
        if let todayEvent = frequencies.first(where: { $0.day == day }){
            if todayEvent.hour > hour {
                // bonne date
                nextDate = Calendar.current.nextDate(after: currentDate, matching: DateComponents(hour : todayEvent.hour, minute : todayEvent.minute), matchingPolicy: .nextTime)
            } else if todayEvent.hour == hour && todayEvent.minute > minute {
                // bonne date
                nextDate = Calendar.current.nextDate(after: currentDate, matching: DateComponents(hour : todayEvent.hour, minute : todayEvent.minute), matchingPolicy: .nextTime)
            }
        }
        if nextDate == nil {
            // Here, there is no event today or event has already occured (hour<actual hour  or  hour= and minute<)
            if day >= (frequencies.max(by: { $0.day < $1.day })?.day)! {
                // Here, the today is the last activity day of the week, so it returns the first of the next week
                let nextEvent = frequencies.min(by: { $0.day < $1.day })
                nextDate = Calendar.current.nextDate(after: currentDate, matching: DateComponents(day : nextEvent!.day, hour : nextEvent!.hour, minute : nextEvent!.minute), matchingPolicy: .nextTime)
            } else {
                // Here, it returns the next activity day : the minimum of all days after today
                let nextEvent = frequencies.filter({ $0.day > day }).min(by: { $0.day < $1.day })
                nextDate = Calendar.current.nextDate(after: currentDate, matching: DateComponents(day : nextEvent!.day, hour : nextEvent!.hour, minute : nextEvent!.minute), matchingPolicy: .nextTime)
            }
        }
        return nextDate!
    }
    
    
    /// validates the next practice
    @discardableResult
    func practiceValidated() -> Activity {
        if let updatedPractice = practices.lastUncheckedPractice() {
            Factory.sharedData.daoPractice.updatePractice(old: updatedPractice, new: practices.validatePractice(dateNextPractice: dateNextPractice()!), patient: Factory.sharedData.patient, activity: self)
        }
        return self
    }
    
    @discardableResult
    func practiceDelayed() -> Activity {
        if let updatedPractice = practices.lastUncheckedPractice() {
            Factory.sharedData.daoPractice.updatePractice(old: updatedPractice, new: practices.delayPractice()!, patient: Factory.sharedData.patient, activity: self)
        }
        return self
    }
    
    @discardableResult
    func practiceCancelled() -> Activity {
        if let updatedPractice = practices.lastUncheckedPractice() {
            Factory.sharedData.daoPractice.updatePractice(old: updatedPractice, new: practices.cancelPractice(dateNextPractice: dateNextPractice()!), patient: Factory.sharedData.patient, activity: self)
        }
        return self
    }

}
