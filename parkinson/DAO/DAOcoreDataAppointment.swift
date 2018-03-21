//
//  DAOcoreDataAppointment.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DAOcoreDataAppointment : DAOappointmentProtocol {
    
    func getAppointments(patient : Patient) -> [Appointment]? {
        return nil
    }
    
    func addAppointment(patient : Patient, appointment: Appointment) -> Bool {
        return false
    }
    
    func updateAppointment(patient : Patient, old: Appointment, new: Appointment) -> Bool {
        return false
    }
    
    func removeAppointment(patient : Patient, appointment: Appointment) -> Bool {
        return false
    }
}
