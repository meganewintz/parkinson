//
//  dateHelper.swift
//  parkinson
//
//  Created by Thierry WINTZ on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation

class DateHelper {
    
    static var dateFormatter = DateFormatter()
    
    static func setDateFormatter() {
        self.dateFormatter.dateFormat = "HH:mm"
    }
}
