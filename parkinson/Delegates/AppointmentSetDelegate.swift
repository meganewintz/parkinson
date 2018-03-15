//
//  AppointmentSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol AppointmentSetDelegate : class {
    
    func appointmentAdded(at : Int)
    func appointmentUpdated(at : Int)
    func appointmentDeleted(at : Int)
    func errorDataBaseRead()
    func errorDataBaseWrite()
}
