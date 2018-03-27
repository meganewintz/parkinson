//
//  TreatmentTableViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 26/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class TreatmentTableViewController: UITableViewController {
    
    var timeFormatter = DateFormatter()
    var dateFormatter = DateFormatter()
    
    func setDateFormatter() {
        self.timeFormatter.dateFormat = "HH:mm"
        self.dateFormatter.dateFormat = "dd.mm.yyyy"
    }
    
    let mySectionNumberWithButton = 1
    
    //var treatment: Treatment
    let sections = ["Médicament", "Dose", "Date de fin"]
    let itemSection0 = ["Nom", "Quantité"]
    var doseHours : [DailyDose] = []
    let items = [["SPASFON"], ["100g"], ["8h"], ["22 aout 2018"] ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateFormatter()
        //self.treatment = Treatment(name: "", quantity: 0, hours: [timeFormatter.date(from: "14:00")!], endDate: dateFormatter.date(from: "14.12.2018")!)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0  {
            return 2
        }
        else if section == 1 {
            return doseHours.count*2
        }
        else {
           return 2
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Configure the cell...
        var timeCell: TimePickerTableViewCell
        var doseCell: DoseTableViewCell
        
        if indexPath.section == 0  {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
            cell.textLabel?.text = itemSection0[indexPath.row]
            cell.detailTextLabel?.text = ""
            return cell
            
        } else if indexPath.section == 1 {
            doseCell = tableView.dequeueReusableCell(withIdentifier: "doseCell")! as! DoseTableViewCell
            doseCell.quantityLabel.text = "1"
            doseCell.comprLabel.text = "comprimé"
            doseCell.hourLabel.text = ""
            return doseCell
            
        } else {
            let dateCell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
            dateCell.textLabel?.text = ""
            return dateCell
        }
    }
 
    @IBAction func addDoseButton(_ sender: UIButton) {
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
