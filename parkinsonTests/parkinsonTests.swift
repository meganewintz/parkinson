//
//  parkinsonTests.swift
//  parkinsonTests
//
//  Created by Thierry WINTZ on 11/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import XCTest
//@testable import parkinson

class parkinsonTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        // Test of patient initialization
        var patient = Factory.sharedData.patient
        XCTAssert(patient.activitySet.count == 0, "Patient's activity set is not empty after initialization")
        XCTAssert(patient.appointmentSet.count == 0, "Patient's appointment set is not empty after initialization")
        XCTAssert(patient.treatmentSet.count == 0, "Patient's treatment set is not empty after initialization")
        
        // Management of an activity
        var activity = Activity(name : "Natation", description : "Effectuer 20 longueurs")
        var activity2 = Activity(name : "Natation", description : "")
        var activity3 = Activity(name : "Marche", description : "")
        patient.activitySet.addActivity(activity: activity)
        XCTAssert(patient.activitySet.count == 1, "Patient's activity set does not contain 1 element after adding")
        patient.activitySet.addActivity(activity: activity2)
        XCTAssert(patient.activitySet.count == 1, "Cannot insert two activities with the same name")
        patient.activitySet.addActivity(activity: activity3)
        XCTAssert(patient.activitySet.count == 2, "Activity not added")
        XCTAssert(patient.activitySet.contains(activity: activity3),"Activity set does not contain an added activity")
        XCTAssert(patient.activitySet.contains(activityName: "Natation"),"Patient does not have natation, an added activity")
        XCTAssert(patient.activitySet.contains(activity: activity2), "Patient contains a activity which cannot be added")
        patient.activitySet.removeActivity(activity : activity2)
        XCTAssert(patient.activitySet.count == 2, "Removing a non present activity has really removed one")
        patient.activitySet.removeActivity(activity: activity)
        XCTAssert(patient.activitySet.count == 1, "An activity has not been removed")
        XCTAssert(!patient.activitySet.contains(activity: activity),"Activity set contains a removed activity")
        patient.activitySet.removeActivity(index: 0)
        XCTAssert(patient.activitySet.count == 0, "An activity has not been removed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
