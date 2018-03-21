//
//  ActivityPeriodiciyViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 16/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ActivityPeriodicityViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timePickerIndexPath: IndexPath? = nil
    var dateFormatter = DateFormatter()
    func setDateFormatter() { // called in viewDidLoad()
        self.dateFormatter.dateFormat = "HH:mm"

    }
    
    var events = [Event]()
    
    func createEvents() { // called in viewDidLoad()
        let event1 = Event(title: "Lundi", time: dateFormatter.date(from: "08:10")!)
        let event2 = Event(title: "Mardi", time: dateFormatter.date(from: "08:10")!)
        let event3 = Event(title: "Mercredi", time: dateFormatter.date(from: "08:10")!)
        let event4 = Event(title: "Jeudi", time: dateFormatter.date(from: "08:10")!)
        let event5 = Event(title: "Vendredi", time: dateFormatter.date(from: "08:10")!)
        let event6 = Event(title: "Samedi", time: dateFormatter.date(from: "08:10")!)
        let event7 = Event(title: "Dimanche", time: dateFormatter.date(from: "08:10")!)

        
        events.append(event1)
        events.append(event2)
        events.append(event3)
        events.append(event4)
        events.append(event5)
        events.append(event6)
        events.append(event7)
    }

    

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateFormatter()
        self.createEvents()
        
        // Do any additional setup after loading the view.
//        self.tableView = tableView
//        self.tableView.dataSource = self
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    /// <#Description#>
    ///
    /// - Parameter tableView: <#tableView description#>
    /// - Returns: <#return value description#>
    func numberOfSections(in tableView: UITableView) -> Int {
        // Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = events.count
        if timePickerIndexPath != nil {
            rows = rows + 1
        }
        return rows
    }
    
    // displaying of the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var timeCell: TimePickerTableViewCell
        var dayCell: DayTableViewCell
        
        if timePickerIndexPath != nil && timePickerIndexPath!.row == indexPath.row {
            //cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell")! as! TimePickerTableViewCell
            timeCell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell")! as! TimePickerTableViewCell
            //let timePicker = cell.viewWithTag(1) as! UItimePicker // set the tag of Date Picker to be 1 in the Attributes Inspector
            let event = events[indexPath.row - 1]
            timeCell.timePicker.setDate(event.time, animated: true)
            //timePicker.setDate(event.time, animated: true)
            return timeCell
  
        } else {
            dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell")! as! DayTableViewCell
            let event = events[indexPath.row]
            dayCell.dayLabel.text = event.title
            dayCell.hourLabel.text = dateFormatter.string(from: event.time)
            return dayCell
        }

//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! PeriodicityTableViewCell
//
//        return displayCell(cell: cell, atIndexPath: indexPath)
        
    }
    // Action when we change the hour in a timePicker (relative to a day)
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: timePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = events[parentIndexPath.row]
        event.time = sender.date
        // change view
        let dayCell = tableView.cellForRow(at: parentIndexPath)! as! DayTableViewCell
        dayCell.hourLabel.text = dateFormatter.string(from: sender.date)
    }
    

    // define row height for the timeCell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight = tableView.rowHeight
        if timePickerIndexPath != nil && timePickerIndexPath!.row == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell")!
            rowHeight = cell.frame.height
        }
        return rowHeight
    }
    
    // Action when we select a row from the tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates() // because there are more than one action below
        if timePickerIndexPath != nil && timePickerIndexPath!.row - 1 == indexPath.row { // case 2
            tableView.deleteRows(at: [timePickerIndexPath!], with: .fade)
            timePickerIndexPath = nil
        } else { // case 1、3
            if timePickerIndexPath != nil { // case 3
                tableView.deleteRows(at: [timePickerIndexPath!], with: .fade)
            }
            timePickerIndexPath = calculateTimePickerIndexPath(indexPathSelected: indexPath)
            tableView.insertRows(at: [timePickerIndexPath!], with: .fade)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    // get the index path for add the timePickerCell
    func calculateTimePickerIndexPath(indexPathSelected: IndexPath) -> IndexPath {
        if timePickerIndexPath != nil && timePickerIndexPath!.row  < indexPathSelected.row { // case 3.2
            return IndexPath(row: indexPathSelected.row, section: 0)
        } else { // case 1、3.1
            return IndexPath(row: indexPathSelected.row + 1, section: 0)
        }
    }
    
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func displayCell(cell: DayTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let event = events[indexPath.row]
        cell.dayLabel.text = event.title
        cell.hourLabel.text = dateFormatter.string(from: event.time as Date)
        return cell

    }
}



