//
//  DoseSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DoseSetDelegate : class {
    
    func doseAdded(dose : Dose)
    func doseUpdated(newValue : Dose)
}
