//
//  DAOappointmentProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 15/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOappointmentProtocol : class {
    
    func addAppointment(patient : Patient, appointment : Appointment) -> Bool
    func updateAppointment(patient : Patient, old : Appointment, new : Appointment) -> Bool
    func removeAppointment(patient : Patient, appointment : Appointment) -> Bool
    func getAppointments(patient : Patient) -> [Appointment]?
}
