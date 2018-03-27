//
//  DAOpracticeProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOpracticeProtocol : class {
    
    func getPractices(patient : Patient, activity : Activity) -> [Practice]?
    func addPractice(practice : Practice, patient : Patient, activity : Activity) -> Bool
    func updatePractice(old : Practice, new : Practice, patient : Patient, activity : Activity) -> Bool
}
