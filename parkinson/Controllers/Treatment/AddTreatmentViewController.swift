//
//  addTreatmentViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 27/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class AddTreatmentViewController: UIViewController {

    var treatmentController : TreatmentTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let controller = self.childViewControllers.first as? TreatmentTableViewController else{
            return
        }
        self.treatmentController = controller
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addTreatmentButton(_ sender: Any) {
        if self.treatmentController.checkDrugInfos() {
            self.treatmentController.saveTreatment(withName: treatmentController.itemSection0[0], withQuantity: treatmentController.itemSection0[1], withDoses: treatmentController.dailyDoses, withEndDate: treatmentController.endDate)
            _ = navigationController?.popViewController(animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
