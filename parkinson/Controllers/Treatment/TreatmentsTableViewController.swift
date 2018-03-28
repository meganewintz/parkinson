//
//  TreatmentsTableViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class TreatmentsTableViewController : NSObject, UITableViewDataSource, TreatmentSetDelegate {

    var treatments: TreatmentSet
    var tableView : UITableView!
    
    var dateFormatter           = DateFormatter()
    
    func setDateFormatter() {
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale    = Locale(identifier: "FR-fr")    }
    
    init(tableView: UITableView, treatments: TreatmentSet) {
        self.treatments = treatments
        super.init()
        self.setDateFormatter()
        self.tableView              = tableView
        self.tableView.dataSource   = self
        self.treatments.addDelegate(delegate: self)
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
        //  Incomplete implementation, return the number of rows
        return self.treatments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "treatmentCell", for: indexPath)
        return displayCell(cell: cell, atIndexPath: indexPath)
        
    }
    
    //  Asks the data source to verify that the given row is editable.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    
    //  Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt: IndexPath) {
        //just managed deleting
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.tableView.beginUpdates()
            self.deleteActivty(withIndex: forRowAt)
            self.tableView.endUpdates()
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Activity Data Management
    
    func deleteActivty(withIndex indexPath: IndexPath) {
        treatments.removeTreatment(at: indexPath.row)
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - TreatmentSetDelegate
    
    func treatmentAdded(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        self.tableView.endUpdates()
        //      self.tableView.reloadData()
    }
    
    func treatmentUpdated(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func treatmentRemoved(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func errorDataBaseRead() {
        return
    }
    
    func errorDataBaseWrite() {
        return
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func displayCell(cell: UITableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        cell.textLabel?.text = treatments[indexPath.row].name + " " + String(treatments[indexPath.row].quantity)
        //cell.detailTextLabel?.text = String(treatments[indexPath.row].quantity)
        let dateNextTreat = treatments[indexPath.row].dateNextTreatment()
//        if dateNextTreat != nil {
//            cell.detailTextLabel?.text = dateFormatter.string(from: dateNextTreat!)
//        }
        return cell
    }
    
}

