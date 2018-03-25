//
//  ActivitySetTests.swift
//  parkinsonTests
//
//  Created by Florent BERLAND on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import XCTest

class ActivitySetTests{
    
    func test(){
        let activity = Activity(name : "Natation", description : "Effectuer 20 longueurs")
        let activity2 = Activity(name : "Natation", description : "")
        let activity3 = Activity(name : "Marche", description : "")
        let activitySet = ActivitySet(dao: nil)
        activitySet.addActivity(activity: activity)
        XCTAssert(activitySet.count == 1, "Patient's activity set does not contain 1 element after adding")
        activitySet.addActivity(activity: activity2)
        XCTAssert(activitySet.count == 1, "Cannot insert two activities with the same name")
        activitySet.addActivity(activity: activity3)
        XCTAssert(activitySet.count == 2, "Activity not added")
        XCTAssert(activitySet.contains(activity: activity3),"Activity set does not contain an added activity")
        XCTAssert(activitySet.contains(activityName: "Natation"),"Patient does not have natation, an added activity")
        XCTAssert(!activitySet.contains(activity: activity2), "Patient contains a activity which cannot be added")
        activitySet.removeActivity(activity : activity2)
        XCTAssert(activitySet.count == 2, "Removing a non present activity has really removed one")
        activitySet.removeActivity(activity: activity)
        XCTAssert(activitySet.count == 1, "An activity has not been removed")
        XCTAssert(!activitySet.contains(activity: activity),"Activity set contains a removed activity")
        activitySet.removeActivity(index: 0)
        XCTAssert(activitySet.count == 0, "An activity has not been removed")
 }
}
