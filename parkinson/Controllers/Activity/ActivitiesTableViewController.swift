//
//  ActivitiesTableViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 12/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import Foundation
import UIKit

class ActivitiesTableViewController : NSObject, UITableViewDataSource, ActivitySetDelegate {
    let factory = Factory.sharedData

    var tableView: UITableView!
    var activities: ActivitySet!
    
    init(tableView: UITableView, activities: ActivitySet) {
        super.init()
        //self.factory.initializeData()

        self.tableView = tableView
        self.tableView.dataSource = self
        self.activities = activities
        //self.activities.delegate = self
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
//            if self.delete(activityWithIndex: IndexPath.row) {
//                self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            }
            self.tableView.endUpdates()
        }
    }
    
    
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - ActivitySetDelegate
    func activityAdded(at: Int) {
        let indexPath = IndexPath(index: at)
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath], with: UITableViewRowAnimation.middle)
        self.tableView.endUpdates()
        //      self.tableView.reloadData()
    }
    
    func activityUpdated(at: Int) {
        let indexPath = IndexPath(index: at)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func activityRemoved(at: Int) {
        let indexPath = IndexPath(index: at)
        self.tableView.beginUpdates()
        self.tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.fade)
        self.tableView.endUpdates()
    }
    
    func errorDataBaseRead() {
        
    }
    func errorDataBaseWrite() {
        
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    @discardableResult
    private func displayCell(cell: ActivityTableViewCell, atIndexPath indexPath: IndexPath) -> UITableViewCell{
        cell.nameLabel.text = activities?[indexPath.row].name
//        cell.descriptionLabel.text = activities?[indexPath.row].description
        
        return cell
    }
}

