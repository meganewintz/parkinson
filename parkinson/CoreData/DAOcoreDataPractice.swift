//
//  DAOcoreDataPractice.swift
//  parkinson
//
//  Created by Florent BERLAND on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DAOcoreDataPractice : DAOpracticeProtocol {
    
    
    func getPractices(patient: Patient, activity: Activity) -> [Practice]? {
        return nil
    }
    
    func addPractice(practice: Practice, patient: Patient, activity: Activity) -> Bool {
        return false
    }
    
    func updatePractice(old: Practice, new: Practice, patient: Patient, activity: Activity) -> Bool {
        return false
    }
    
    
}
