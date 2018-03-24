//
//  DailyDose.swift
//  parkinson
//
//  Created by Florent BERLAND on 13/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DailyDose {
    
    public var dailyPeriod : Float
    public var quantity : Int
    
    internal init(dailyPeriod : Float, quantity : Int){
        self.dailyPeriod = dailyPeriod
        self.quantity = quantity
    }
}
