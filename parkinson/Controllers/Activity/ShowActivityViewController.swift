//
//  ShowActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ShowActivityViewController: UIViewController {

    var tableViewController: FrequenceActivityTableViewController!
    let activities      = Factory.sharedData.patient.activitySet
    var dateFormatter   = DateFormatter()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var activity: Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
        if let activityShown = self.activity{
            self.nameTextField.text      = activityShown.name
            self.nameTextField.isEnabled = false
            self.descrTextView.text     = activityShown.description
            self.descrTextView.isEditable = false
            let frequencies = activityShown.frequencies
            tableViewController = FrequenceActivityTableViewController(tableView: tableView, frequencies: frequencies )
            tableViewController.isAccessibilityElement = false
        }
        else{
            self.nameTextField.isEnabled  = true
            self.descrTextView.isEditable = true
        }
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

    func createEvents() -> [Event] {
        var events = [Event]()
        let event1 = Event(title: "Lundi", time: dateFormatter.date(from: "14:00")!)
        let event2 = Event(title: "Mardi", time: dateFormatter.date(from: "14:00")!)
        let event3 = Event(title: "Mercredi", time: dateFormatter.date(from: "14:00")!)
        let event4 = Event(title: "Jeudi", time: dateFormatter.date(from: "14:00")!)
        let event5 = Event(title: "Vendredi", time: dateFormatter.date(from: "14:00")!)
        let event6 = Event(title: "Samedi", time: dateFormatter.date(from: "14:00")!)
        let event7 = Event(title: "Dimanche", time: dateFormatter.date(from: "14:00")!)
        
        events.append(event1)
        events.append(event2)
        events.append(event3)
        events.append(event4)
        events.append(event5)
        events.append(event6)
        events.append(event7)
        return events
    }

}
