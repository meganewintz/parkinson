//
//  DAOcoreDataAppointment.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DAOcoreDataAppointment : DAOappointmentProtocol {
    
    func getAppointments() -> AppointmentSet? {
        return nil
    }
    
    func addAppointment(appointment: Appointment) -> Bool {
        return false
    }
    
    func updateAppointment(old: Appointment, new: Appointment) -> Bool {
        return false
    }
    
    func removeAppointment(appointment: Appointment) -> Bool {
        return false
    }
}
