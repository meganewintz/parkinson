//
//  DAOtreatmentProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOtreatmentProtocol {
    
    func getTreatments(patient : Patient) -> [Treatment]?
    func addTreatment(patient : Patient, treatment : Treatment) -> Bool
    func updateTreatment(patient : Patient, old : Treatment, new : Treatment) -> Bool
    func removeTreatment(patient : Patient, treatment : Treatment) -> Bool
}
