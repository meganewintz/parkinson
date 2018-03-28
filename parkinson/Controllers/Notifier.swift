//
//  Notifier.swift
//  parkinson
//
//  Created by Florent BERLAND on 25/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

class Notifier {
    
    var title : String
    var shortTopic : String
    var fullBody : String
    var userData : AnyObject?
    var timer : Timer?
    var notifReq : UNNotificationRequest?
    
    
    /// initialize a notification with a text and a content
    ///
    /// - Parameter title : the title of the notification and the event cell
    /// - Parameter shortTopic : the body of the notification
    /// - Parameter fullBody : the body of the event cell
    /// - Parameter userData : Activity/Treatment/Appointment which must be updated
    init(title : String, shortTopic : String, fullBody : String, _ userData : AnyObject?){
        self.title = title
        self.shortTopic = shortTopic
        self.fullBody = fullBody
        self.userData = userData
    }
    
    
    /// display the notification at the indicated date
    /// - Parameter date : the date of the notification and the event cell popup
    /// - Parameter controller : the controller responsible of displaying the event cell
    func displayOn(date : Date, controller : ViewController){
        
        // Remove pending requests
        if notifReq != nil {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notifReq!.identifier])
        }        
        
        let notification = UNMutableNotificationContent()
        notification.title = title
        notification.body = shortTopic
        let trigger = UNCalendarNotificationTrigger(dateMatching : Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date), repeats: false)
        notifReq = UNNotificationRequest(identifier: UUID().uuidString, content: notification, trigger: trigger)
        UNUserNotificationCenter.current().add(notifReq!, withCompletionHandler: nil)
        
        timer = Timer(fireAt: Calendar.current.date(byAdding: DateComponents(minute : 1), to: Date())!, interval: 0, target: controller, selector: (#selector(controller.addEvent)), userInfo: self, repeats: false)
        RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
    }
}
