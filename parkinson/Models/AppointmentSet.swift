//
//  TreatmentSet.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class AppointmentSet {
    
    private var appointmentSet : [Appointment]
    private var delegates : [AppointmentSetDelegate]
    var dao : DAOappointmentProtocol
    
    
    /// init
    ///
    /// initialize an 'AppointmentSet', empty.
    ///
    init(dao : DAOappointmentProtocol){
        appointmentSet = [Appointment]()
        delegates = [AppointmentSetDelegate]()
        self.dao = dao
    }
    
    
    /// addAppointment
    ///
    /// add an Appointment to the set
    ///
    /// - Parameters:
    ///   - appointment: `Appointment`
    /// - Returns : 'AppointmentSet' with the appointment enter in parameter
    @discardableResult
    func addAppointment(appointment : Appointment) -> AppointmentSet {
        if dao.addAppointment(appointment) {
            appointmentSet.append(appointment)
            for d in delegates {
                d.appointmentAdded(at : self.count-1)
            }
        } else {
            for d in delegates {
                d.errorDataBaseWrite()
            }
        }
        return self
    }
    
    
    /// removeAppointment
    ///
    /// remove an appointment to the set
    ///
    /// - Parameters:
    ///   - appointment: `Appointment`
    /// - Returns : 'AppointmentSet' without the appointment enter in parameter
    @discardableResult
    func removeAppointment(appointment : Appointment) -> AppointmentSet {
        if let index=appointmentSet.index(where: { $0 === appointment })
        {
            if dao.removeAppointment(appointment) {
                appointmentSet.remove(at: index)
                for d in delegates {
                    d.appointmentDeleted(at : index)
                }
            } else {
                for d in delegates {
                    d.errorDataBaseWrite()
                }
            }
        }
        return self
    }
    
    
    /// count
    ///
    /// number of `Appointment` in the set
    ///
    /// - Returns : 'Int'
    public var count : Int {
        return appointmentSet.count
    }
    
    
    /// contains
    ///
    ///
    /// - Parameters:
    ///   - appointment: `Appointment`
    /// - Returns : True if the appointment is in the set
    func contains(appointment : Appointment) -> Bool {
        return appointmentSet.contains(where: { $0 === appointment})
    }
    
    
    /// nextAppointment
    ///
    /// give the next appointment programed
    ///
    /// - Returns : Appointment?
    func nextAppointment() -> Appointment? {
        guard appointmentSet.count > 0 else { return nil }
        
        // get only the future appointments
        let currentDate = Date()
        var futureAppointments = [Appointment]()
        for appointment in appointmentSet {
            if appointment.date > currentDate {
                futureAppointments.append(appointment)
            }
        }
        
        if futureAppointments.count == 0 {
            // no future appointment
            return nil
        } else {
            // find the appointment which minimise the time interval between its date and the current date
            var nearestAppointment = futureAppointments[0]
            var smallestInterval = nearestAppointment.date.timeIntervalSince(currentDate)
            for appointment in futureAppointments {
                if appointment.date.timeIntervalSince(currentDate) < smallestInterval {
                    smallestInterval = appointment.date.timeIntervalSince(currentDate)
                    nearestAppointment = appointment
                }
            }
            return nearestAppointment
        }
    }
    
    
    /// updateAppointment
    ///
    /// updates an appointment with a new value
    ///
    /// - Parameters:
    ///   - old: `Appointment`
    ///   - new: Appointment
    /// - Returns : 'AppointmentSet' with the appointment updated
    @discardableResult
    func updateAppointment(old : Appointment, new : Appointment) -> AppointmentSet {
        if let index=appointmentSet.index(where: { $0 === old })
        {
            if dao.updateAppointment(old : old, new : new) {
                appointmentSet[index] = new
                for d : AppointmentSetDelegate in delegates {
                    d.appointmentUpdated(at : index)
                }
            } else {
                for d in delegates {
                    d.errorDataBaseWrite()
                }
            }
        }
        return self
    }
    
    
    /// checkConflict
    ///
    /// return true if the appointment in parameter happens at the same time with another one in the set
    ///
    /// - Parameters:
    ///   - appointment: Appointment
    ///
    /// Returns : true if the appointment in parameter happens at the same time with another one in the set
    func checkConflict(appointment : Appointment) -> Bool {
        return appointmentSet.contains(where : { $0.date == appointment.date })
    }
    
    
    /// addDelegate
    ///
    /// add a delegate to this model if it is not already present
    ///
    /// - Parameters:
    ///   - delegate: `AppointmentSetDelegate`
    ///
    /// Returns : 'AppointmentSet' the current instance with the delegate in parameter
    @discardableResult
    func addDelegate(delegate : AppointmentSetDelegate) -> AppointmentSet
    {
        if !delegates.contains(where: { $0 === delegate }){
            delegates.append(delegate)
        }
        return self
    }
    
    
    /// removeDelegate
    ///
    /// remove a delegate to this model
    ///
    /// - Parameters:
    ///   - delegate: `AppointmentSetDelegate`
    ///
    /// Returns : 'AppointmentSet' the current instance without the delegate in parameter
    @discardableResult
    func removeDelegate(delegate : AppointmentSetDelegate) -> AppointmentSet {
        if let index = delegates.index(where: { $0 === delegate })
        {
            delegates.remove(at: index)
        }
        return self
    }

}