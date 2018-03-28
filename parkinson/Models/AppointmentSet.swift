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
    internal init(dao : DAOappointmentProtocol){
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
        if dao.addAppointment(patient : Factory.sharedData.patient, appointment : appointment) {
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
            if dao.removeAppointment(patient : Factory.sharedData.patient, appointment : appointment) {
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
        let currentDate = Date()
        return appointmentSet.filter({ $0.date > currentDate }).min(by: { $0.date < $1.date })
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
            if dao.updateAppointment(patient : Factory.sharedData.patient, old : old, new : new) {
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
