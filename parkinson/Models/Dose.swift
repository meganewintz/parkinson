//
//  Dose.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Dose {
    
    public var isTaken : Bool
    public var reminderNb : Int
    public var dateFirstReminder : Date?
    
    
    /// init
    ///
    /// initialize a 'Dose', no taken and no reminded.
    ///
    internal init(){
        isTaken = false
        reminderNb = 0
    }
    
    
    /// dateNextReminder
    ///
    /// returns th date of the next reminder programmed if the initial date is programmed and not taken
    func dateNextReminder() -> Date? {
        guard dateFirstReminder != nil else { return nil }
        if isTaken {
            return nil
        } else {
            return dateFirstReminder?.addingTimeInterval(Double(5*60*reminderNb))
        }
    }
}
