//
//  DAOcoreDataTreatment.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation


class DAOcoreDataTreatment: DAOtreatmentProtocol {
    
    func getTreatments() -> TreatmentSet? {
        return nil
    }
    
    func addTreatment(treatment: Treatment) -> Bool {
        return false
    }
    
    func updateTreatment(old: Treatment, new: Treatment) -> Bool {
        return false
    }
    
    func removeTreatment(treatment: Treatment) -> Bool {
        return false
    }
}
