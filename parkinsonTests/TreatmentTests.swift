//
//  TreatmentTests.swift
//  parkinsonTests
//
//  Created by Florent BERLAND on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import XCTest

class TreatmentTests {
    
//    func test(){
//        let dailyDoseMorning = DailyDose(dailyPeriod: Calendar.current.date(from: DateComponents(hour : 9, minute : 0))!, quantity: 1)
//        let dailyDoseNoon = DailyDose(dailyPeriod: Calendar.current.date(from: DateComponents(hour : 13, minute : 0))!, quantity: 2)
//        let dailyDoseEvening = DailyDose(dailyPeriod: Calendar.current.date(from: DateComponents(hour : 20, minute : 30))!, quantity: 1)
//        let treatment = Treatment(name: "Doudouliprane", description: "Facultatif", type: "Comprimé", endDate: Calendar.current.date(byAdding: DateComponents(day : 2), to: Date())!)
//        XCTAssert(treatment.name == "Doudouliprane", "Name is not Doudouliprane")
//        XCTAssert(treatment.description == "Facultatif", "Description is not Facultatif")
//        XCTAssert(treatment.type == "Comprimé", "Type is not Comprimé")
//        XCTAssert(!treatment.isFinished(), "Treatment cannot be finished now")
//        XCTAssert(treatment.dailyDoseCount == 0, "Treatment contains a daily dose")
//        treatment.addDailyDose(dailyDose: dailyDoseNoon)
//        XCTAssert(treatment.dailyDoseCount == 1, "Not exactly one daily dose")
//        treatment.addDailyDose(dailyDose: dailyDoseNoon)
//        XCTAssert(treatment.dailyDoseCount == 1, "The noon dose has been addeed two times")
//        treatment.addDailyDose(dailyDose: dailyDoseMorning)
//        XCTAssert(treatment.getDailyDose(at: 0).quantity == 1, "The morning quantity is not 1")
//        treatment.removeDailyDose(at: 0)
//        XCTAssert(treatment.getDailyDose(at: 0).quantity == 2, "The noon quantity is not 2")
//        treatment.addDailyDose(dailyDose: dailyDoseMorning).addDailyDose(dailyDose: dailyDoseEvening)
//        XCTAssert(Calendar.current.component(.hour, from: treatment.dateNextTreatment()!) == 20, "Next dose is not on evening") // Depends on the current hour
//        treatment.endDate = Date()
//        XCTAssert(treatment.isFinished(), "Treatment must be finished")
//        XCTAssert(treatment.dateNextTreatment() == nil, "Treatment has a next dose whereas it must be finished")
//    }
    
}
