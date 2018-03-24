//
//  EventTests.swift
//  parkinsonTests
//
//  Created by Florent BERLAND on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import XCTest

class EventTests {
    
    func test(){
        let event = Event(title : "jeudi", time : Calendar.current.date(from : DateComponents(hour : 8, minute : 30))!)
        XCTAssert(event.title == "jeudi", "Title is not jeudi")
        XCTAssert(event.day == 4, "Day is not jeudi")
        XCTAssert(event.hour == 8, "Hour is not 8")
        XCTAssert(event.minute == 30, "Minute is not 30")
        XCTAssert(!event.enable, "Event is enabled")
    }
}
