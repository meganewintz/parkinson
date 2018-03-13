//
//  PracticeSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol PracticeSetDelegate {
    
    func practiceAdded(practice : Practice)
    func practiceUpdated(newValue : Practice)
}
