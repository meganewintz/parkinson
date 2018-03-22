//
//  ActivityPeriodiciyViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 16/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit


protocol FrequenceActivityViewControllerDelegate {
    func updateActivityFrenquencies(frequencies: [Event])
}

class FrequenceActivityViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var timePickerIndexPath: IndexPath? = nil
    var dateFormatter = DateFormatter()
    var frequencies = [Event]()
    var delegate: FrequenceActivityViewControllerDelegate? = nil

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateFormatter()
        //self.createEvents()

        //let precView = navigationController as! AddActivityViewController
        //events = precView.events
        
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

//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "dayCell", for: indexPath) as! PeriodicityTableViewCell
//
//        return displayCell(cell: cell, atIndexPath: indexPath)
        
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
    // MARK: - Action
    
    
    // Action when we change the hour in a timePicker (relative to a day)
    @IBAction func timePicker(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: timePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = frequencies[parentIndexPath.row]
        event.time = sender.date
        // change view
        let dayCell = tableView.cellForRow(at: parentIndexPath)! as! DayTableViewCell
        dayCell.hourLabel.text = dateFormatter.string(from: sender.date)
    }
    
    // Action when we click on a switch button
    @IBAction func switchButton(_ sender: UISwitch) {
        // get the index of the cell of the witch button we clicked
        let point = tableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView")
        }
        
        let dayCell = tableView.cellForRow(at: indexPath)! as! DayTableViewCell

        // If we turn on the button
        if sender.isOn {
            dayCell.hourLabel.isHidden = false //display the hour
            dayCell.setSelected(false, animated: false)
            self.frequencies[indexPath.row].enable = true

        }
        // If we turn off the button
        else {
            dayCell.hourLabel.isHidden = true // hide the hour
            dayCell.setSelected(true, animated: false)
            self.frequencies[indexPath.row].enable = true
        }
        
    }
    
    
    @IBAction func validateButton(_ sender: Any) {
        delegate?.updateActivityFrenquencies(frequencies: frequencies)
        var i = 0
        while i < frequencies.count && !frequencies[i].enable {
            i += 1
        }
        if i <= frequencies.count || frequencies[frequencies.count-1].enable{
            _ = navigationController?.popViewController(animated: true)
        }
        else {
            alert(title: "Oups!", message: "Vous devez sélectionner au moins 1 jour")
        }
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
    
    func setDateFormatter() { // called in viewDidLoad()
        self.dateFormatter.dateFormat = "HH:mm"
    }

    
    
    func alert(title: String,  message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok ",
                                     style: .default)
        
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
}



