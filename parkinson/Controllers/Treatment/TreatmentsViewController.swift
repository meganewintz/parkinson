//
//  TreatmentsViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class TreatmentsViewController: UIViewController {

    var tableViewController     : TreatmentsTableViewController!
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //self.displayActivities()
        self.tableViewController = TreatmentsTableViewController(tableView: self.tableView, treatments: Factory.sharedData.patient.treatmentSet)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    let segueEditTreatmentID = "editTreatmentSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueEditTreatmentID {
            let indexPath = self.tableView.indexPathForSelectedRow
            let editTreatmentViewController = segue.destination as! EditTreatmentViewController
            editTreatmentViewController.treatment = self.tableViewController.treatments[(indexPath?.row)!]
            self.tableView.deselectRow(at: indexPath!, animated: true)
            
        }
    }
}
