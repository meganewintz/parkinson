//
//  DailyDoseTests.swift
//  parkinsonTests
//
//  Created by Florent BERLAND on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import XCTest

class DailyDoseTests {
    
    func test() {
        let dose = DailyDose(dailyPeriod: Calendar.current.date(from: DateComponents(hour : 8, minute : 45))!, quantity: 2)
        XCTAssert(dose.quantity == 2, "Quantity is not 2")
        XCTAssert(dose.hour == 8, "Hour is not 8")
        XCTAssert(dose.minute == 45, "Minute is not 45")
    }
}
