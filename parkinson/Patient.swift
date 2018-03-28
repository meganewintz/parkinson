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
        
        self.activitySet = ActivitySet(dao: daoActivity)
        self.treatmentSet = TreatmentSet(dao: daoTreatment)
        self.appointmentSet = AppointmentSet(dao: daoAppointment)

    }
    
    func addActivity(activity: Activity) {
        self.activitySet.addActivity(activity: activity)
    }
    
    func addTreatment(treatment: Treatment) {
        self.treatmentSet.addTreatment(treatment: treatment)
    }
}
