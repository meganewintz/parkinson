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
    
    static func initiateSets() {
        let patient = Factory.sharedData.patient
        // initialize Activities
        let daoActivity = DAOcoreDataActivity()
        if let activities = daoActivity.getActivities(patient: patient) {
            patient.activitySet.initialize(activities: activities)
        }
        
        //initialize Treatments
        let daoTreatment = DAOcoreDataTreatment()
        //daoTreatment.removeAllTreatments()
        if let treatments = daoTreatment.getTreatments(patient: patient) {
            patient.treatmentSet.initialize(treatments: treatments)
        }
    }
}
