//
//  TimeEvent.swift
//  parkinson
//
//  Created by Thierry WINTZ on 18/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

// class use in FrequenceActivityViewController
// an event has a title, a time and it's enable or not.
class Event {
    let title: String
    var time: Date
    var enable: Bool
    internal init(title: String, time: Date) {
        self.title = title
        self.time = time
        self.enable = false
    }
    
    var day : Int {
        return Calendar.current.weekdaySymbols.index(where : { $0 == title} )! + 1
    }
    
    var hour : Int {
        return Calendar.current.component(.hour, from: time)
    }
    
    var minute : Int {
        return Calendar.current.component(.minute, from: time)
    }
}
