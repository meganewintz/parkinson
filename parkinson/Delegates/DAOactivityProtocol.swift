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
    func getActivities(patient : Patient) -> [Activity]?
    func getActivity(patient : Patient, name: String) -> Activity?
    func addActivity(patient : Patient, activity: Activity) -> Bool
    func removeActivity(patient : Patient, activity: Activity) -> Bool
    func updateActivity(patient : Patient, oldActivity: Activity, newActivity: Activity) -> Bool
}
