//
//  DAOCoreDataActivityType.swift
//  parkinson
//
//  Created by Thierry WINTZ on 20/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DAOcoreDataActivityType {
    func getActivityTypes() -> [String] {
        
        // Get context
        let context = CoreDataManager.context
        
        let activityTypesData: [ActivityTypeData]
        var activityTypes: [String] = []
        
        // Create Fetch Request
        let request: NSFetchRequest<ActivityTypeData> = ActivityTypeData.fetchRequest()
        
        // Execute Request
        do {
            try activityTypesData = context.fetch(request)
            for type in activityTypesData {
                activityTypes.append(type.name!)
            }
        }
        catch let error as NSError {
            print (error, error.userInfo)

        }
        return activityTypes
    }
}
