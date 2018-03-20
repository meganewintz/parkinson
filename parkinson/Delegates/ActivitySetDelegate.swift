//
//  ActivitySetDelegate.swift
//  parkinsonProject
//
//  Created by Florent BERLAND on 04/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol ActivitySetDelegate : class{

    func activityAdded(at: Int)
    func activityUpdated(at: Int)
    func activityRemoved(at: Int)
    func errorDataBaseRead()
    func errorDataBaseWrite()
}
