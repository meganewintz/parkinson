//
//  TabBarController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 16/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit
import UserNotifications

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert])
        { (success, error) in
            if success {
                print("Notifications permission granted")
            } else {
                print("Notifications permission denied")
            }
        }
        let a = Notifier(title: "Notification", content: "Déclenchée à une certaine date")
        a.displayOn(date: Calendar.current.date(byAdding: DateComponents(minute : 1), to: Date())!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
