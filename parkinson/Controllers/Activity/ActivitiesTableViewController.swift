//
//  ActivitiesTableViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 17/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ActivitiesTableViewController : NSObject, UITableViewDataSource, ActivitySetDelegate {
    
    var activities: ActivitySet
    
    var tableView: UITableView!

    
    init(tableView: UITableView, activities: ActivitySet) {
        self.activities = activities
        super.init()
        //self.factory.initializeData()
        
        self.tableView = tableView
        self.tableView.dataSource = self
        self.activities.addDelegate(delegate: self)
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
        return self.activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityTableViewCell
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
        activities.removeActivity(index: indexPath.row)
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - ActivitySetDelegate
    func activityAdded(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        self.tableView.endUpdates()
        //      self.tableView.reloadData()
    }
    
    func activityUpdated(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func activityRemoved(at: Int) {
        let indexPath = IndexPath(row: at, section: 0)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func activityAlreadyExist() {
        
    }
    
    func errorDataBaseRead() {
        
    }
    func errorDataBaseWrite() {
        
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func displayCell(cell: ActivityTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        //cell.nameLabel.text = activities?[indexPath.row].name
        //        cell.descriptionLabel.text = activities?[indexPath.row].description
        cell.nameLabel.text = activities[indexPath.row].name
        cell.descriptionLabel.text = activities[indexPath.row].description

        
        return cell
    }

}


