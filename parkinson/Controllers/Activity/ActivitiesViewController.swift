//
//  ActivitiesViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 12/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit
import CoreData

class ActivitiesViewController: UIViewController {

    var tableViewController     : ActivitiesTableViewController!
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //self.displayActivities()
        self.tableViewController = ActivitiesTableViewController(tableView: self.tableView, activities: Factory.sharedData.patient.activitySet)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    let segueEditActivityID = "editActivitySegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueEditActivityID {
            let indexPath = self.tableView.indexPathForSelectedRow
            let editActivityViewController = segue.destination as! EditActivityViewController
            editActivityViewController.activity = self.tableViewController.activities[(indexPath?.row)!]
            self.tableView.deselectRow(at: indexPath!, animated: true)
    
        }
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Utilities -
    
    func alertError(errorMsg error: String, userInfo user: String = "") {
        let alert = UIAlertController(title: error,
                                      message: user,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok ",
                                         style: .default)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
}
