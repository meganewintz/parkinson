//
//  ActivityPeriodiciyViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 16/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class FrequenceActivityTableViewController : NSObject, UITableViewDataSource, UITableViewDelegate{
    
    var timePickerIndexPath     : IndexPath? = nil
    var dateFormatter           = DateFormatter()
    var frequencies             = [Event]()
    var tableView               : UITableView!

    init(tableView: UITableView, frequencies: [Event]) {
        super.init()
        self.setDateFormatter()
        self.frequencies            = frequencies
        self.tableView              = tableView
        self.tableView.dataSource   = self
        self.tableView.delegate     = self
}

    // MARK: - Table view data source
    
    // Nulber of section
    func numberOfSections(in tableView: UITableView) -> Int {
        // Incomplete implementation, return the number of sections
        return 1
    }

    // Number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = frequencies.count
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
            timeCell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell")! as! TimePickerTableViewCell
            let event = frequencies[indexPath.row - 1]
            timeCell.timePicker.setDate(event.time, animated: true)
            return timeCell
  
        } else {
            dayCell = tableView.dequeueReusableCell(withIdentifier: "dayCell")! as! DayTableViewCell
            if self.frequencies[indexPath.row].enable {
                dayCell.switchButton.isOn = true
            } else {
                dayCell.hourLabel.isHidden = true // hide the hour
                //tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                dayCell.setSelected(true, animated: false)

            }
            let event = frequencies[indexPath.row]
            dayCell.dayLabel.text = event.title
            dayCell.hourLabel.text = dateFormatter.string(from: event.time)

            return dayCell
        }
        //return displayCell(cell: cell, atIndexPath: indexPath)
        
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

    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    

    @discardableResult
    private func displayCell(cell: DayTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        let event = frequencies[indexPath.row]
        cell.dayLabel.text = event.title
        cell.hourLabel.text = dateFormatter.string(from: event.time as Date)
        return cell

    }
    
    // get the index path for add the timePickerCell
    func calculateTimePickerIndexPath(indexPathSelected: IndexPath) -> IndexPath {
        if timePickerIndexPath != nil && timePickerIndexPath!.row  < indexPathSelected.row { // case 3.2
            return IndexPath(row: indexPathSelected.row, section: 0)
        } else { // case 1、3.1
            return IndexPath(row: indexPathSelected.row + 1, section: 0)
        }
    }
    
    func setDateFormatter() {
        self.dateFormatter.dateFormat = "HH:mm"
    }
    
    
}



