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
    init(name : String, description: String) {
        self.name = name
        self.description = description
        self.frequencies = []
        self.practices = PracticesSet()
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
    }
    
    /// dateNextPractice
    ///
    /// give the date of the next practice programed
    ///
    /// - Returns : 'Date?' the date of the next practice programed
    func dateNextPractice() -> Date? {
        return nil;
    }

}
