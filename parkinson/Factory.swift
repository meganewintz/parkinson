//
//  Factory.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Factory {
    
    static public let sharedData = Factory()
    
    let patient: Patient
    let daoPractice = DAOcoreDataPractice()
    let daoActivity = DAOcoreDataActivity()
    let daoTreatment = DAOcoreDataTreatment()
    let daoAppointment = DAOcoreDataAppointment()
    
    private init() {
        self.patient = Patient(daoActivity: daoActivity, daoTreatment: daoTreatment, daoAppointment : daoAppointment, daoPractice : daoPractice)
        //Factory.initiateActivities()
        
    }
    
    static func initiateActivities() {
        let patient = Factory.sharedData.patient
        let dao = DAOcoreDataActivity()
        if let activities = dao.getActivities(patient: patient) {
            patient.activitySet.initialize(activities: activities)
        }
    }
}
