//
//  Factory.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Factory {
    
    static public let sharedData = Factory(daoActivity: DAOcoreDataActivity(), daoTreatment: DAOcoreDataTreatment(), daoAppointment : DAOcoreDataAppointment())
    
    let patient: Patient
    
    private init(daoActivity: DAOactivityProtocol, daoTreatment: DAOtreatmentProtocol, daoAppointment : DAOappointmentProtocol) {
        self.patient = Patient(daoActivity: daoActivity, daoTreatment: daoTreatment, daoAppointment : daoAppointment)
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
        if let treatments = daoTreatment.getTreatments(patient: patient) {
            patient.treatmentSet.initialize(treatments: treatments)
        }
    }
}
