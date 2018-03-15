//
//  TreatmentSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol TreatmentSetDelegate : class {
    
    func treatmentAdded(treatment : Treatment)
    func treatmentUpdated(old : Treatment, new : Treatment)
    func treatmentRemoved(deletedValue : Treatment)
}
