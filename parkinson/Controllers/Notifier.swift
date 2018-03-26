//
//  Notifier.swift
//  parkinson
//
//  Created by Florent BERLAND on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import UserNotifications

class Notifier {
    
    var title : String
    var content : String
    
    
    /// initialize a notification with a text and a content
    init(title : String, content : String){
        self.title = title
        self.content = content
    }
    
    
    /// display the notification at the indicated date
    func displayOn(date : Date){
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.body = content
        let trigger = UNCalendarNotificationTrigger(dateMatching : Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
