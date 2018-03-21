//
//  DAOactivityTypeProtocol.swift
//  parkinson
//
//  Created by Florent BERLAND on 20/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

protocol DAOactivityTypeProtocol : class {
    
    func getActivityTypes() -> [ActivityType]?
}
