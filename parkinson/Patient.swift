//
//  Patient.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Patient {
    
    // var firstname
    // var surname
    var activitySet: ActivitySet
    var treatmentSet: TreatmentSet
    var appointmentSet : AppointmentSet
    
    init(daoActivity: DAOactivityProtocol, daoTreatment: DAOtreatmentProtocol, daoAppointment : DAOappointmentProtocol) {
        
        // activitySet
//        if daoActivity.getActivities() != nil {
//            self.activitySet = daoActivity.getActivities()!
//        }
//        else {
            self.activitySet = ActivitySet(dao: daoActivity)
//        if let set = daoActivity.getActivities(patient: Factory.sharedData.patient)  {
//            self.pset = set
//        }
//        }
        
        // treatmentSet
//        if daoTreatment.getTreatments() != nil {
//            self.treatmentSet = daoTreatment.getTreatments()!
//        }
//        else {
            self.treatmentSet = TreatmentSet(dao: daoTreatment)
//        }
        
        // appointmentSet
//        if daoAppointment.getAppointments() != nil {
//            self.appointmentSet = daoAppointment.getAppointments()!
//        }
//        else {
            self.appointmentSet = AppointmentSet(dao: daoAppointment)
//        }
    }
    
    func addActivity(activity: Activity) {
        self.activitySet.addActivity(activity: activity)
    }
}
