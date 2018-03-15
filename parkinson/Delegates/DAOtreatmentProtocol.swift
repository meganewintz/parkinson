//
//  DAOtreatmentProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOtreatmentProtocol {
    
    func getTreatements() -> TreatmentSet?
    func addTreatment(treatment : Treatment) -> Bool
    func updateTreatment(old : Treatment, new : Treatment) -> Bool
    func removeTreatment(treatment : Treatment) -> Bool
}
