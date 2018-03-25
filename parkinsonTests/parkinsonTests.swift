//
//  parkinsonTests.swift
//  parkinsonTests
//
//  Created by Thierry WINTZ on 11/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import XCTest

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
        
        let eventTest = EventTests()
        eventTest.test()
        let activityTest = ActivityTests()
        activityTest.test()
        let dailyDoseTest = DailyDoseTests()
        dailyDoseTest.test()
        let treatmentTest = TreatmentTests()
        treatmentTest.test()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
