//
//  Activity.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

/// Activity type
///

/// ---- Proprieties
///
/// name : String
///
/// description : String


/// ---- Methods
///

/// init
///
/// initialize an 'Activity' with his name and his description
///
/// - Parameters:
///   - name: `String`
///   - description:  `String`


/// dateNextPractice
///
/// give the date of the next practice programed
///
/// - Returns : 'Date' the date of the next practice programed

class Activity {
    
    var name : String
    var description: String
    private var practices : PracticesSet
    
    
    /// init
    ///
    /// initialize an 'Activity' with his name and his description
    ///
    /// - Parameters:
    ///   - name: `String`
    ///   - description:  `String`
    init(name : String, description: String) {
        self.name = name
        self.description = description
        self.practices = PracticesSet()
    }
    
    
    /// dateNextPractice
    ///
    /// give the date of the next practice programed
    ///
    /// - Returns : 'Date' the date of the next practice programed

}
