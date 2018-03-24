//
//  AddActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 19/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate{

    var tableViewController: FrequenceActivityTableViewController!
    let activities      = Factory.sharedData.patient.activitySet
    var dateFormatter   = DateFormatter()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descrTextView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDateFormatter()
        self.tableViewController = FrequenceActivityTableViewController(tableView: self.tableView)
        
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Actions -
    
    // action when we click on the validate Button
    @IBAction func validerButton(_ sender: Any) {
        guard let nameToSave = nameTextField.text else {
            alertError(errorMsg: "Veuillez entrer un nom d'activité")
            return
        }
        guard let descrToSave = descrTextView.text else {
            alertError(errorMsg: "Veuillez entrer une description d'activité")
            return
        }
        if nameToSave == "" {
            alertError(errorMsg: "Veuillez entrer un nom d'activité")
            return
        }
        if descrToSave == "" {
            alertError(errorMsg: "Veuillez entrer une description d'activité")
            return
        }
        if !checkPeriodicity() {
            alert(title: "Oups!", message: "Vous devez sélectionner au moins 1 jour")
            return
        }
        let frequencies = getEnableFrequencies(frequencies:self.tableViewController.frequencies)
        self.saveActivity(withName: nameToSave, withDescr: descrToSave, withFreq: frequencies)
        _ = navigationController?.popViewController(animated: true)

    }
    
    // Action when we click on a switch button
    @IBAction func switchAction(_ sender: UISwitch) {
        let point = tableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = tableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView")
        }
        
        let dayCell = tableView.cellForRow(at: indexPath)! as! DayTableViewCell
        
        // If we turn on the button
        if sender.isOn {
            dayCell.hourLabel.isHidden = false //display the hour
            dayCell.setSelected(false, animated: false)
            self.tableViewController.frequencies[indexPath.row].enable = true
            
        }
            // If we turn off the button
        else {
            dayCell.hourLabel.isHidden = true // hide the hour
            dayCell.setSelected(true, animated: false)
            self.tableViewController.frequencies[indexPath.row].enable = true
        }
    }
    
    // Action when we change the hour in a timePicker (relative to a day)
    @IBAction func timePickerAction(_ sender: UIDatePicker) {
        let parentIndexPath = IndexPath(row: tableViewController.timePickerIndexPath!.row - 1, section: 0)
        // change model
        let event = self.tableViewController.frequencies[parentIndexPath.row]
        event.time = sender.date
        // change view
        let dayCell = tableView.cellForRow(at: parentIndexPath)! as! DayTableViewCell
        dayCell.hourLabel.text = dateFormatter.string(from: sender.date)
        for t in tableViewController.frequencies {
            print(t.title, dateFormatter.string(from: t.time))
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Activity Data Management -
        
    func saveActivity(withName name: String, withDescr descr: String, withFreq frequencies: [Event]) {
        activities.addActivity(activity: Activity(name: name, description: descr, frequencies: frequencies))
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Delegate -
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }


    //-------------------------------------------------------------------------------------------------
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    // Used to send the data frequencies already choose
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "frequencyChoiceSegue" {
            //let frequenceVC = segue.destination as! FrequenceActivityTableViewController
            //frequenceVC.delegate = self
            //frequenceVC.frequencies = self.frequencies
            
        }
    }
    
    
    //-------------------------------------------------------------------------------------------------
    // MARK: - Utilities -
    
    // Return the activity effectively choose by the user
    func getEnableFrequencies(frequencies: [Event]) -> [Event] {
        var activityFreq = [Event]()
        for freq in frequencies {
            if freq.enable {
                activityFreq.append(freq)
            }
        }
        return activityFreq
    }

    func checkPeriodicity() -> Bool {
        //delegate?.updateActivityFrenquencies(frequencies: frequencies)
        var frequencies = tableViewController.frequencies
        var i = 0
        while i < frequencies.count && !frequencies[i].enable {
            i += 1
        }
        if i <= frequencies.count || frequencies[frequencies.count-1].enable{
            return true
        }
        else {
            return false
        }
    }
    
    func setDateFormatter() {
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
