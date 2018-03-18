//
//  TimeEvent.swift
//  parkinson
//
//  Created by Thierry WINTZ on 18/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
class Event {
    let title: String
    var time: Date
    init(title: String, time: Date) {
        self.title = title
        self.time = time
    }
}
