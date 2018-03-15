//
//  Treatment.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Treatment	 {
    
    public var name : String
    public var description : String
    public var type : String
    public var doses : DoseSet

    private var dailyDoses : [DailyDose]
    
    /// init
    ///
    /// initialize a 'Treatment' with his name, his description, his type and his frequency
    ///
    /// - Parameters:
    ///   - name: `String`
    ///   - description:  `String`
    ///   - type : String
    ///   - frequency : String
    init(name : String, description : String, type : String){
        self.name = name
        self.description = description
        self.type = type
        self.doses = DoseSet()
        self.dailyDoses = [DailyDose]()
    }
    
    
    /// dateNextTreatment
    ///
    /// give the date of the next dose programed if there is one
    ///
    /// - Returns : 'Date?' the date of the next dose programed
    public func dateNextTreatment() -> Date? {
        return nil
    }
    
    
    /// nextDoseQuantity
    ///
    /// give the quantity of drug of the next dose programmed
    ///
    /// - Returns : 'Int?' the quantity of the next dose programmed
    public func nextDoseQuantity() -> Int? {
        return nil
    }
    
    
    /// addDailyDose
    ///
    /// add the quantity property with a daily period for a dose
    ///
    /// - Parameters:
    ///   - dailyDose: `DailyDose`
    ///
    /// Returns : the treatment with the daily dose added
    public func addDailyDose(dailyDose : DailyDose) -> Treatment {
        dailyDoses.append(dailyDose)
        dailyDoses.sort(by:{ $0.dailyPeriod < $1.dailyPeriod } )
        return self
    }
    
    
    /// dailyDoseCount
    ///
    /// returns the number of daily doses programmed
    ///
    /// Returns : Int the number of daily doses programmed
    public var dailyDoseCount : Int {
        return dailyDoses.count
    }
    
    
    /// getDailyDose
    ///
    /// returns the i-th Dailydose sorted by ascending hour
    ///
    /// - Parameters:
    ///   - i: int
    ///
    /// Returns : 'DailyDose?' the i-th dose of the day
    public func getDailyDose(index i : Int) -> DailyDose? {
        guard i>=0 && i<self.dailyDoseCount else { return nil }
        return dailyDoses[i]
    }
    
    
    /// removeDailyDose
    ///
    /// remove the i-th dose of the day, sorted by ascending hour
    ///
    /// - Parameters:
    ///   - i:Int
    ///
    /// Returns : Treatment without the i-th daily dose in parameter
    public func removeDailyDose(i : Int) -> Treatment {
        dailyDoses.remove(at : i)
        return self
    }
}
