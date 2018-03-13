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
    
    init(date:Date, doctor:String, specialty:String){
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
    
    static func ==(lhs : Appointment, rhs : Appointment) -> Bool {
        return lhs.date == rhs.date &&
            lhs.doctor == rhs.doctor &&
            lhs.specialty == rhs.specialty
    }
    
    static func !=(lhs : Appointment, rhs : Appointment) -> Bool {
        return !(lhs == rhs)
    }
}
