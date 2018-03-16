//
//  DAOactivityProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOactivityProtocol : class {
    
    /// Get all the activities from CoreData.
    ///
    /// - Returns: ActivitySet containing all the activities.
    func getActivities() -> ActivitySet?
    func getActivity(name: String) -> Activity?
    func addActivity(activity: Activity) -> Bool
    func removeActivity(activity: Activity) -> Bool
    func updateActivity(oldActivity: Activity, newActivity: Activity) -> Bool
}
