//
//  AppointmentSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol AppointmentSetDelegate : class {
    
    func appointmentAdded(appointment : Appointment)
    func appointmentUpdated(old : Appointment, new : Appointment)
    func appointmentDeleted(deletedAppointment : Appointment)
}
