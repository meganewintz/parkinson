//
//  DailyDose.swift
//  parkinson
//
//  Created by Florent BERLAND on 13/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DailyDose {
    
    public var dailyPeriod : Date
    public var quantity : Int
    
    init(dailyPeriod : Date, quantity : Int){
        self.dailyPeriod = dailyPeriod
        self.quantity = quantity
    }
    
    var hour : Int {
        return Calendar.current.component(.hour, from: dailyPeriod)
    }
    
    var minute : Int {
        return Calendar.current.component(.minute, from: dailyPeriod)
    }
}
