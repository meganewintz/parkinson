//
//  Treatment.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class Appointment {
    
    public var date : Date
    public var doctor : String
    public var specialty : String
    public var address : String?
    public var phoneNumber : String?
    public var journeyTime : Int?
    public var note : String?
    
    internal init(date:Date, doctor:String, specialty:String){
        self.date = date
        self.doctor = doctor
        self.specialty = specialty
    }
    
    init(date:Date, doctor:String, specialty:String, address:String, phoneNumber:String, journeyTime:Int, note:String) {
        self.date = date
        self.doctor = doctor
        self.specialty = specialty
        self.address = address
        self.phoneNumber = phoneNumber
        self.journeyTime = journeyTime
        self.note = note
    }
    
    
    /// gives the date of the reminder 5 minutes before the time to leave
    func appointmentReminder() -> Date? {
        if journeyTime == nil { return nil }
        return Calendar.current.date(byAdding: DateComponents(minute : -journeyTime! - 5), to: date)!
    }
    
    
    /// give the date of the reminder the day before the appointment, at 10:00
    func appointmentDayBefore() -> Date {
        return Calendar.current.date(bySettingHour: 10, minute: 0, second: 0, of: Calendar.current.date(byAdding: DateComponents(day : -1), to: date)!)!
    }
    
    
    /// indicate if the appointment need an evaluation session
    func needEvaluation() -> Bool {
        return specialty == "Neurologue"
    }
    
}
