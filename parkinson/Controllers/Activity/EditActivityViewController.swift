//
//  EditActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class EditActivityViewController: UIViewController {

    var activityController : ActivityViewController!
    var activity: Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DateHelper.setDateFormatter()
        guard let controller = self.childViewControllers.first as? ActivityViewController else{
            return
        }
        self.activityController = controller
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Action when we click on the update button
    @IBAction func updateButton(_ sender: Any) {
        guard let nameToSave = self.activityController.nameTextField.text else {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Vous devez entrer un nom pour votre activité")
            return
        }
        guard let descrToSave = self.activityController.descrTextView.text else {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez entrer une description d'activité")
            return
        }
        if nameToSave == "" {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Vous devez entrer un nom pour votre activité")
            return
        }
        if descrToSave == "" {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Veuillez entrer une description d'activité")
            return
        }
        if !self.activityController.checkPeriodicity() {
            DialogBoxHelper.alert(view: self, WithTitle: "Oups!", andMessage: "Vous devez sélectionner au moins 1 jour")
            return
        }
        let frequencies = self.activityController.getEnableFrequencies(frequencies:self.activityController.tableViewController.frequencies)
        self.activityController.saveActivity(withName: nameToSave, withDescr: descrToSave, withFreq: frequencies)
        _ = navigationController?.popViewController(animated: true)
        
    }

    //-------------------------------------------------------------------------------------------------
    // MARK: - Navigation
    
    let segueShowActivityID = "showActivitySegue"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueShowActivityID {
            DateHelper.setDateFormatter()
            let showActivityViewController = segue.destination as! ActivityViewController
            //activity.frequencies = completeEvents(events: activity.frequencies)
            showActivityViewController.activity = self.activity
        }
    }
    
    func completeEvents(events: [Event]) -> [Event] {
        var freq = events
        
        if freq.count < 1 || freq[0].title != "lundi" {
            freq.insert(Event(title: "lundi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 0)
        }
        if freq.count < 2 || freq[1].title != "mardi" {
            freq.insert(Event(title: "mardi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 1)
        }
        if freq.count < 3 || freq[2].title != "mercredi" {
            freq.insert(Event(title: "mercredi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 2)
        }
        if freq.count < 4 || freq[3].title != "jeudi" {
            freq.insert(Event(title: "jeudi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 3)
        }
        if freq.count < 5 || freq[4].title != "vendredi" {
            freq.insert(Event(title: "vendredi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 4)
        }
        if freq.count < 6 || freq[5].title != "samedi" {
            freq.insert(Event(title: "samedi", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 5)
        }
        if freq.count < 7 || freq[6].title != "dimanche" {
            freq.insert(Event(title: "dimanche", time: DateHelper.dateFormatter.date(from: "14:00")!), at: 6)
        }
        return freq
    }

}
