//
//  State.swift
//  parkinsonProject
//
//  Created by Thierry WINTZ on 28/02/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class State {
    
    public var state : TypeOfState?
    public var date : Date
    
    
    /// init
    ///
    /// initialize a 'State'. initialize the date.
    ///
    /// - Parameters:
    ///   - date : Date
    internal init(date : Date) {
        self.date = date
    }
}
