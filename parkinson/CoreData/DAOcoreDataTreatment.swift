//
//  DAOcoreDataTreatment.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation


class DAOcoreDataTreatment: DAOtreatmentProtocol {
    
    func getTreatments(patient : Patient) -> [Treatment]? {
        return nil
    }
    
    func addTreatment(patient : Patient, treatment: Treatment) -> Bool {
        return false
    }
    
    func updateTreatment(patient : Patient, old: Treatment, new: Treatment) -> Bool {
        return false
    }
    
    func removeTreatment(patient : Patient, treatment: Treatment) -> Bool {
        return false
    }
}
