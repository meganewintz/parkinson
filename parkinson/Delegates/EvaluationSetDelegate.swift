//
//  EvaluationSetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol EvaluationSetDelegate : class {
    
    func evaluationAdded(at : Int)
    func evaluationUpdated(at : Int)
    func evaluationRemoved(at : Int)
    func errorDataBaseRead()
    func errorDataBaseWrite()
}

