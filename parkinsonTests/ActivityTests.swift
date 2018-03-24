//
//  ActivityTest.swift
//  parkinsonTests
//
//  Created by Florent BERLAND on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import XCTest

class ActivityTests {
    
    func test(){
        let eventLundi = Event(title: "lundi", time : Calendar.current.date(from: DateComponents(hour : 8, minute : 30))!)
        let eventMercredi = Event(title : "mercredi", time : Calendar.current.date(from : DateComponents(hour : 10, minute : 0))!)
        let eventSamedi = Event(title : "samedi", time : Calendar.current.date(from : DateComponents(hour : 20, minute : 30))!)
        let eventTest = Event(title : "samedi", time : Calendar.current.date(from : DateComponents(hour : 21, minute : 50))!)
        let frequencies = [eventTest]
        let activity = Activity(name: "Natation", description: "Nager", frequencies: frequencies)
        
        XCTAssert(activity.name == "Natation", "Name is not Natation")
        XCTAssert(activity.description == "Nager", "Description is not Nager")
        XCTAssert(activity.dateNextPractice() != nil, "There is no next practice")
        XCTAssert(Calendar.current.component(.weekday, from: activity.dateNextPractice()!) == 7, "Next practice is not on satursday")
    }
    
}
