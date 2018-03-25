//
//  AddActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 19/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ActivityViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    var tableViewController: FrequenceActivityTableViewController!
    let activities      = Factory.sharedData.patient.activitySet
    var activity: Activity?

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateHelper.setDateFormatter()
        
        if let activityShown = self.activity{
            self.nameTextField.text = activityShown.name
            self.descrTextView.text = activityShown.description
            let frequencies         = activityShown.frequencies
            self.nameTextField.isEnabled = false
            tableViewController     = FrequenceActivityTableViewController(tableView: tableView, frequencies: frequencies )
        }
        else{
            self.tableViewController = FrequenceActivityTableViewController(tableView: self.tableView, frequencies: createEvents())
        }    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Actions -
    
    
    // Action when we click on a switch button
    @IBAction func switchAction(_ sender: UISwitch) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView")
        }
        
        let dayCell = tableView.cellForRow(at: indexPath)! as! DayTableViewCell
        
        // If we turn on the button
        if sender.isOn {
            dayCell.hourLabel.isHidden = false //display the hour
            dayCell.setSelected(false, animated: false)
            self.tableViewController.frequencies[indexPath.row].enable = true
            
        }
            // If we turn off the button
        else {
            dayCell.hourLabel.isHidden = true // hide the hour
            dayCell.setSelected(true, animated: false)
            self.tableViewController.frequencies[indexPath.row].enable = true
        }
    }
    
    // Action when we change the hour in a timePicker (relative to a day)
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: tableViewController.timePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = self.tableViewController.frequencies[parentIndexPath.row]
        event.time = sender.date
        // change view
        let dayCell = tableView.cellForRow(at: parentIndexPath)! as! DayTableViewCell
        dayCell.hourLabel.text = DateHelper.dateFormatter.string(from: sender.date)
        for t in tableViewController.frequencies {
            print(t.title, DateHelper.dateFormatter.string(from: t.time))
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Activity Data Management -
        
    func saveActivity(withName name: String, withDescr descr: String, withFreq frequencies: [Event]) {
        activities.addActivity(activity: Activity(name: name, description: descr, frequencies: frequencies))
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Delegate -
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Utilities -
    
    func createEvents() -> [Event] {
        var events = [Event]()
        let event1 = Event(title: "lundi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        let event2 = Event(title: "mardi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        let event3 = Event(title: "mercredi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        let event4 = Event(title: "jeudi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        
        let event5 = Event(title: "vendredi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        let event6 = Event(title: "samedi", time: DateHelper.dateFormatter.date(from: "14:00")!)
        let event7 = Event(title: "dimanche", time: DateHelper.dateFormatter.date(from: "14:00")!)
        
        events.append(event1)
        events.append(event2)
        events.append(event3)
        events.append(event4)
        events.append(event5)
        events.append(event6)
        events.append(event7)
        return events
    }
    
    // Return the activity effectively choose by the user
    func getEnableFrequencies(frequencies: [Event]) -> [Event] {
        var activityFreq = [Event]()
        for freq in frequencies {
            if freq.enable {
                activityFreq.append(freq)
            }
        }
        return activityFreq
    }

    func checkPeriodicity() -> Bool {
        //delegate?.updateActivityFrenquencies(frequencies: frequencies)
        var frequencies = tableViewController.frequencies
        var i = 0
        while i < frequencies.count && !frequencies[i].enable {
            i += 1
        }
        if i <= frequencies.count || frequencies[frequencies.count-1].enable{
            return true
        }
        else {
            return false
        }
    }

}
