//
//  EditTreatmentViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class EditTreatmentViewController: UIViewController {

    var treatment: Treatment!
    @IBOutlet weak var editTreatmentButton: UIButton!

    var treatmentController : TreatmentTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateHelper.setDateFormatter()
        guard let controller = self.childViewControllers.first as? TreatmentTableViewController else{
            return
        }
        self.treatmentController = controller
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action when we click on the update button
    @IBAction func updateButton(_ sender: Any) {

        _ = navigationController?.popViewController(animated: true)
        
    }
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    let segueShowTreatmentID = "showTreatmentSegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueShowTreatmentID {
            DateHelper.setDateFormatter()
            let showActivityViewController = segue.destination as! TreatmentTableViewController
            showActivityViewController.itemSection0[0] = treatment.name
            showActivityViewController.itemSection0[1] = String(treatment.quantity)
            showActivityViewController.dailyDoses = treatment.dailyDoses
            showActivityViewController.endDate = treatment.endDate
        }
    }


}
