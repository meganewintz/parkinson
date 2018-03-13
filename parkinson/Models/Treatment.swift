//
//  Treatment.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

/// Treatment type
///

/// ---- Properties
///
/// name : String
///
/// description : String
///
/// type : string
///
/// frequency : int


/// ---- Methods
///

/// init
///
/// initialize a 'Treatment' with his name, his description, his type and his frequency
///
/// - Parameters:
///   - name: `String`
///   - description:  `String`
///   - type : String
///   - frequency : String


/// dateNextTreatment
///
/// give the date of the next dose programed
///
/// - Returns : 'Date' the date of the next dose programed


/// nextDoseQuantity
///
/// give the quantity of drug of the next dose programmed
///
/// - Reruns : Int the quantity of the next dose programmed


/// addDailyDose
///
/// add the quantity property with a daily period for a dose


/// dailyDoseCount
///
/// returns the number of daily doses programmed
///
/// Returns : Int the number of daily doses programmed


/// getDailyDose
///
/// returns the i-th Dailydose sorted by ascending hour
///
/// - Parameters:
///   - i: int
///
/// Returns : DailyDose the i-th dose of the day


/// removeDailyDose
///
/// remove the i-th dose of the day, sorted by ascending hour
///
/// - Parameters:
///   - i:Int


class Treatment	 {
    
}
