//
//  Patient.swift
//  parkinson
//
//  Created by Megane WINTZ on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Patient {
    
    var activitySet: ActivitySet
    var treatmentSet: TreatmentSet
    var appointmentSet : AppointmentSet
    
    init(daoActivity: DAOactivityProtocol, daoTreatment: DAOtreatmentProtocol, daoAppointment : DAOappointmentProtocol) {
        //activitySet = ActivitySet(dao: daoActivity)
        activitySet = ActivitySet()
        treatmentSet = TreatmentSet(dao: daoTreatment)
        appointmentSet = AppointmentSet(dao : daoAppointment)
    }
}
