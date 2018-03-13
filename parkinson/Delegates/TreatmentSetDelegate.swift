//
//  TreatmentSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol TreatmentSetDelegate {
    
    func treatmentAddded(treatment : Treatment)
    func treatmentUpdated(newValue : Treatment)
    func treatmentRemoved(deletedValue : Treatment)
}
