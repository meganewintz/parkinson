//
//  Practice.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Practice {

    public var isDone : Bool
    public var reminderNb : Int
    public var dateFirstReminder : Date?

    
    /// init
    ///
    /// initialize a 'Practise', no taken and no reminded.
    ///
    init() {
        isDone = false
        reminderNb = 0
    }
    
    
    /// nextReminder
    ///
    /// date of the next reminder
    ///
    /// - Returns : 'Date' of the next reminder
    func dateNextReminder() -> Date? {
        guard dateFirstReminder != nil else { return nil }
        if isDone {
            return nil
        } else {
            return dateFirstReminder?.addingTimeInterval(Double(5*60*reminderNb))
        }
    }
}
