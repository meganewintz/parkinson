//
//  TreatmentSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol TreatmentSetDelegate : class {
    
    func treatmentAdded(at : Int)
    func treatmentUpdated(at : Int)
    func treatmentRemoved(at : Int)
    func errorDataBaseRead()
    func errorDataBaseWrite()
}
