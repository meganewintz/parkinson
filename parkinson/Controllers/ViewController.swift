//
//  ViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 11/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ActivitySetDelegate, TreatmentSetDelegate {

    var notifiers = [Notifier]()
    let activitySet = Factory.sharedData.patient.activitySet
    let treatmentSet = Factory.sharedData.patient.treatmentSet
    var activityNotifier : Notifier?
    var treatmentNotifier : Notifier?
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activitySet.addDelegate(delegate: self)
        if let activity = activitySet.nextActivity() {
            scheduleActivity(activity)
        }
        
        treatmentSet.addDelegate(delegate: self)
        let treatments = treatmentSet.nextTreatments()
        scheduleTreatment(treatments)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addEvent(timer : Timer){
        notifiers.append(timer.userInfo as! Notifier)
        eventsTableView.reloadData()
    }
    
    
    /// creates scheduled event for next activity
    /// call it again to reschedule
    func scheduleActivity(_ activity : Activity){
        activityNotifier?.cancelNotification()
        activityNotifier = Notifier(title: activity.name, shortTopic: "Cliquez pour plus d'informations", fullBody: activity.description, activity)
        activityNotifier!.displayOn(date: activity.dateNextPractice()!, controller: self)
        print("Next activity scheduled : " + activity.name + " at " + String(Calendar.current.component(.hour, from: activity.dateNextPractice()!)) + "h" + String(Calendar.current.component(.minute, from: activity.dateNextPractice()!)))
    }
    
    /// same for treatments
    /// many treatments may occur at the same time
    func scheduleTreatment(_ treatments : [Treatment]){
        if treatments.count > 0 {
            treatmentNotifier?.cancelNotification()
            var topic = treatments[0].name
            var body = "Vous devez prendre : " + String(describing: treatments[0].nextDoseQuantity()) + " comprimés de " + treatments[0].name + " " + String(treatments[0].quantity)
            if treatments.count >= 2 {
                for i in 1..<treatments.count {
                    topic += ", " + treatments[i].name
                    body += ", " + String(describing: treatments[i].nextDoseQuantity()) + " comprimés de " + treatments[i].name + " " + String(treatments[i].quantity)
                }
            }
            treatmentNotifier = Notifier(title : "C'est l'heure de vos médicaments !", shortTopic: topic, fullBody: body, treatments as AnyObject)
            treatmentNotifier!.displayOn(date: treatments[0].dateNextTreatment()!, controller: self)
            print("Next treatments scheduled : " + topic + " at " + String(Calendar.current.component(.hour, from: treatments[0].dateNextTreatment()!)) + "h" + String(Calendar.current.component(.minute, from: treatments[0].dateNextTreatment()!)))
        }
    }

    // MARK: - Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifiers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        cell.titleLabel.text = notifiers[indexPath.row].title
        cell.bodyLabel.text = notifiers[indexPath.row].fullBody
        return cell
    }
    
    // MARK: - Events buttons
    
    @IBAction func validated(_ sender: UIButton) {
        let point = eventsTableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = eventsTableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView") }
        
        guard indexPath.row < notifiers.count else { return }
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceValidated()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            scheduleTreatment(treatmentSet.nextTreatments())
        }
        
        notifiers.remove(at: indexPath.row)
        eventsTableView.reloadData()
    }
    
    @IBAction func delayed(_ sender: UIButton) {
        let point = eventsTableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = eventsTableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView") }
        notifiers.remove(at: indexPath.row)
        eventsTableView.reloadData()
        
        guard indexPath.row < notifiers.count else { return }
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceDelayed()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            scheduleTreatment(treatmentSet.nextTreatments())
        }
    }
    
    @IBAction func cancelled(_ sender: UIButton) {
        let point = eventsTableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = eventsTableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView") }
        notifiers.remove(at: indexPath.row)
        eventsTableView.reloadData()
        
        guard indexPath.row < notifiers.count else { return }
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceCancelled()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            scheduleTreatment(treatmentSet.nextTreatments())
        }
    }
    
    // MARK: - ActivitySetDelegate
    
    func activityAdded(at index: Int) {
        if let activity = activitySet.nextActivity() {
            scheduleActivity(activity)
        }
    }
    
    func activityUpdated(at index: Int) {
        if let activity = activitySet.nextActivity() {
            scheduleActivity(activity)
        }
    }
    
    func activityRemoved(at index: Int) {
        if let activity = activitySet.nextActivity() {
            scheduleActivity(activity)
        }
    }
    
    func activityAlreadyExist() {
        
    }
    
    func errorDataBaseRead() {
        
    }
    
    func errorDataBaseWrite() {
        
    }
    
    func treatmentAdded(at: Int) {
        scheduleTreatment(treatmentSet.nextTreatments())
    }
    
    func treatmentUpdated(at: Int) {
        scheduleTreatment(treatmentSet.nextTreatments())
    }
    
    func treatmentRemoved(at: Int) {
        scheduleTreatment(treatmentSet.nextTreatments())
    }
    
}

