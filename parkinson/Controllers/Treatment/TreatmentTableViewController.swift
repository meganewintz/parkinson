//
//  TreatmentTableViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 26/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class TreatmentTableViewController: UITableViewController {
    
    var timeFormatter           = DateFormatter()
    var dateFormatter           = DateFormatter()
    var timePickerIndexPath     : IndexPath? = nil
    var datePickerIndexPath     : IndexPath? = nil
    
    func setDateFormatter() {
        self.timeFormatter.dateFormat = "HH:mm"
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale    = Locale(identifier: "FR-fr")    }
    
    let mySectionNumberWithButton = 1
    var treatments = Factory.sharedData.patient.treatmentSet
    var drugsManager = DrugsManager()
    var drugNames: [String] = []
    let sections = ["Médicament", "Fréquence", "Date de fin"]
    var itemSection0 = ["Nom", "Quantité"]
    var dailyDoses : [DailyDose] = []
    var endDate : Date?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateFormatter()
        self.drugNames = drugsManager.getDrugsName()!
        
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
        
        // number of rows SECTION 0
        if section == 0  {
            return 2
        }
            
        // number of rows SECTION 1
        else if section == 1 {
            var rows = dailyDoses.count + 1
            if self.timePickerIndexPath != nil {
                rows = rows + 1
            }
            return rows
            
        // number of rows SECTION 2
        }
        else {
            var rows = 1
            if self.datePickerIndexPath != nil {
                rows = rows + 1
            }
            return rows
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        // Configure the cell...
        var timePickerCell: TimePickerTreatmentTableViewCell
        var datePickerCell: DatePickerTreatmentTableViewCell
        var doseCell: DoseTableViewCell
        
        // Configure SECTION 0
        if indexPath.section == 0  {
            let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath)
            detailCell.textLabel?.text = itemSection0[indexPath.row]
            return detailCell
          
        // Configure SECTION 1
        } else if indexPath.section == 1 {
        
            if self.timePickerIndexPath != nil && self.timePickerIndexPath!.row == indexPath.row {
                timePickerCell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell") as! TimePickerTreatmentTableViewCell
                let currentDose = dailyDoses[indexPath.row - 1]
                timePickerCell.timePicker.setDate(currentDose.dailyPeriod, animated: true)
                return timePickerCell
            }
            else if indexPath.row == tableView.numberOfRows(inSection: 1) - 1 {
                let addDoseCell = tableView.dequeueReusableCell(withIdentifier: "addDoseCell", for: indexPath)
                return addDoseCell
            }
            else {
                let dose = dailyDoses[indexPath.row]
                doseCell = tableView.dequeueReusableCell(withIdentifier: "doseCell")! as! DoseTableViewCell
                doseCell.quantityLabel.text = String(dose.quantity)
                doseCell.comprLabel.text = "comprimé"
                doseCell.hourLabel.text = timeFormatter.string(from: dose.dailyPeriod)
                return doseCell
            }
        
        // Configure SECTION 2
        } else {
            if self.datePickerIndexPath != nil && self.datePickerIndexPath!.row == indexPath.row {
                datePickerCell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as! DatePickerTreatmentTableViewCell
                if self.endDate != nil {
                datePickerCell.datePicker.setDate(endDate!, animated: true)
                }
                return datePickerCell
            }
            else {
                let dateCell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                if self.endDate != nil {
                    dateCell.textLabel?.text = dateFormatter.string(from: endDate!)
                }
                else {
                    dateCell.textLabel?.text = ""
                }
                return dateCell
            }
        }
    }
 
    // define row height for the timeCell
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var rowHeight = tableView.rowHeight
        
        // SECTION 1
        if indexPath.section  == 1 && self.timePickerIndexPath != nil && self.timePickerIndexPath!.row == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timePickerCell")!
            rowHeight = cell.frame.height
        }
        
        // SECTION 2
        if indexPath.section  == 2 && self.datePickerIndexPath != nil && self.datePickerIndexPath!.row == indexPath.row {
            let cell = tableView.dequeueReusableCell(withIdentifier: "datePickerCell")!
            rowHeight = cell.frame.height
        }
        return rowHeight
    }
    
    // Action when we select a row from the tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.beginUpdates() // because there are more than one action below
        
        // action select row SECTION 1
        if indexPath.section == 1 {
            if self.timePickerIndexPath != nil && self.timePickerIndexPath!.row - 1 == indexPath.row { // case 2
                tableView.deleteRows(at: [self.timePickerIndexPath!], with: .fade)
                self.timePickerIndexPath = nil
            } else { // case 1、3
                //
                if self.timePickerIndexPath != nil { // case 3
                    tableView.deleteRows(at: [self.timePickerIndexPath!], with: .fade)
                }
                self.timePickerIndexPath = calculatedatePickerIndexPath(indexPathSelected: indexPath, datePickerIndexPath: self.timePickerIndexPath)
                tableView.insertRows(at: [self.timePickerIndexPath!], with: .fade)
            }
        }
        
        // action select row SECTION 2
        if indexPath.section == 2 {
            if self.datePickerIndexPath != nil && self.datePickerIndexPath!.row - 1 == indexPath.row { // case 2
                tableView.deleteRows(at: [self.datePickerIndexPath!], with: .fade)
                self.datePickerIndexPath = nil
            } else { // case 1、3
                //
                if self.datePickerIndexPath != nil { // case 3
                    tableView.deleteRows(at: [self.datePickerIndexPath!], with: .fade)
                }
                self.datePickerIndexPath = calculatedatePickerIndexPath(indexPathSelected: indexPath, datePickerIndexPath: self.datePickerIndexPath)
                tableView.insertRows(at: [self.datePickerIndexPath!], with: .fade)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.endUpdates()
    }
    
    //  Asks the data source to verify that the given row is editable.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        
        // we can  delete only the rows corresponding to the doseCell
        if indexPath.section == 1 && indexPath.row != tableView.numberOfRows(inSection: 1)-1 {
            return true
        }
        else {
            return false
        }
    }
    
    //  Asks the data source to commit the insertion or deletion of a specified row in the receiver.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt: IndexPath) {
        //just managed deleting
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            self.tableView.beginUpdates()
            self.deleteDoses(withIndex: forRowAt)
            self.tableView.endUpdates()
        }
    }
    
    // -----------------------------------------------------
    // MARK: - Action
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        guard let indexPathStepper = tableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView")
        }
        let doseCell = tableView.cellForRow(at: indexPathStepper) as! DoseTableViewCell
        
        if sender.value == 1 {
            doseCell.quantityLabel.text = String(Int(sender.value))
            doseCell.comprLabel.text = "comprimé"
        }
        else {
            doseCell.quantityLabel.text = String(Int(sender.value))
            doseCell.comprLabel.text = "comprimés"
        }
    }
    @IBAction func addDoseButton(_ sender: UIButton) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        guard let indexPathAddButton = tableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView")
        }
        let indexPathNewRow = IndexPath(row: indexPathAddButton.row, section: indexPathAddButton.section)
        dailyDoses.append(DailyDose(dailyPeriod: timeFormatter.date(from: "14:00")!, quantity: 1))
        tableView.insertRows(at: [indexPathNewRow], with: .fade)
    }
    
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: self.timePickerIndexPath!.row - 1, section: 1)
        // change model
        let dose = self.dailyDoses[parentIndexPath.row]
        dose.dailyPeriod = sender.date
        // change view
        let doseCell = tableView.cellForRow(at: parentIndexPath) as! DoseTableViewCell
        doseCell.hourLabel.text = timeFormatter.string(from: sender.date)
    }
    
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: self.datePickerIndexPath!.row - 1, section: 2)
        // change model
        self.endDate = sender.date
        // change view
        let dateCell = tableView.cellForRow(at: parentIndexPath)
        dateCell?.textLabel?.text = dateFormatter.string(from: sender.date)
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

    
    // MARK: - Navigation

     let seguedrugChoiceID = "drugChoiceSegue"
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == seguedrugChoiceID {
         let indexPath = self.tableView.indexPathForSelectedRow
         let drugChoiceViewController = segue.destination as! DrugChoiceViewController
            
            // Case 1 : we clicked on the drugName cell
            if indexPath?.row == 0 {
                drugChoiceViewController.toDisplay = self.drugNames
                
                
            }
            // Case 2 : we clicked on the drugQuantity cell
            else {
                guard let quantities = drugsManager.getQuantitiesDrugInString(ofDrug: self.itemSection0[0]) else {
                    return
                }
                drugChoiceViewController.toDisplay = quantities
                drugChoiceViewController.rowOfTreatmentTableViewSelected = 1
            }
         //editActivityViewController.activity = self.tableViewController.activities[(indexPath?.row)!]
         self.tableView.deselectRow(at: indexPath!, animated: true)
         }
     }
    
    
    
    @IBAction func unwindAfterDrugChoice(segue: UIStoryboardSegue) {
        let controller = segue.source as! DrugChoiceViewController
        let indexPath = IndexPath(row: controller.rowOfTreatmentTableViewSelected, section: 0)
        let cell = tableView.cellForRow(at: indexPath)!
        cell.textLabel?.text = controller.selected
        if controller.rowOfTreatmentTableViewSelected == 0{
            self.itemSection0[0] = controller.selected
            self.itemSection0[1] = ""
            let cellQuantity = tableView.cellForRow(at: IndexPath(row: 1, section: 0))!
            cellQuantity.textLabel?.text = self.itemSection0[1]
        }
        else {
            self.itemSection0[1] = controller.selected
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - convenience methods
    
    // get the index path for add the timePickerCell
    func calculatedatePickerIndexPath(indexPathSelected: IndexPath, datePickerIndexPath: IndexPath?) -> IndexPath {
        if datePickerIndexPath != nil && datePickerIndexPath!.row  < indexPathSelected.row { // case 3.2
            return IndexPath(row: indexPathSelected.row, section: indexPathSelected.section)
        } else { // case 1、3.1
            return IndexPath(row: indexPathSelected.row + 1, section: indexPathSelected.section)
        }
    }
    
    func saveTreatment(withName name: String, withQuantity quantity: String, withDoses doses: [DailyDose], withEndDate endDate: Date) {
        let treatment = Treatment(name: name, quantity: Float(quantity)!, dailyDoses: doses, endDate: endDate)
        self.treatments.addTreatment(treatment: treatment)
    }
    
    func deleteDoses(withIndex indexPath: IndexPath) {
        dailyDoses.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .none)
    }
    
    /// check if the informations enter are complete
    ///
    /// - Returns: true if all the informations are completed
    func checkDrugInfos() -> Bool {
        
        if itemSection0[0] == "" || itemSection0[0] == "Nom" {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez choisir un médicament")
            return false
        }
        else if itemSection0[1] == "" || itemSection0[1] == "Nom" {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez choisir une quantité pour votre médicament")
            return false
        }
        else if dailyDoses.count == 0 {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez choisir au moins une fréquence de prise")
            return false
        }
        else if endDate == nil {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez choisir une date de fin")
            return false
        }
        return true
        
    }
}
