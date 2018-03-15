//
//  Factory.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Factory {
    
    static public let sharedData: Factory(daoActivity: DAOcoreDataActivity(), daoTreatment: DAOcoreDataTreatment())
    
    let patient: Patient
    
    private init(daoActivity: DAOactivityProtocol, daoTreatment: DAOtreatmentProtocol) {
        patient = Patient(daoActivity: daoActivity, daoTreatment: daoTreatment)
    }
}
