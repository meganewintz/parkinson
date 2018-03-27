//
//  ViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 11/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ActivitySetDelegate {

    var notifiers = [Notifier]()
    let activitySet = Factory.sharedData.patient.activitySet
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        activitySet.addDelegate(delegate: self)
        if let activity = activitySet.nextActivity() {
            scheduleActivity(activity)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addEvent(timer : Timer){
        notifiers.append(timer.userInfo as! Notifier)
        eventsTableView.reloadData()
    }
    
    
    /// creates scheduled event for each activity
    /// - Warning : this must be called only one time, after loading the app
    func scheduleActivity(_ activity : Activity){
        let notifier = Notifier(title: activity.name, shortTopic: "Cliquer pour plus d'informations", fullBody: activity.description, activity)
        notifier.displayOn(date: activity.dateNextPractice()!, controller: self)
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
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceValidated()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            
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
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceDelayed()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            
        }
    }
    
    @IBAction func cancelled(_ sender: UIButton) {
        let point = eventsTableView.convert(CGPoint.zero, from: sender)
        guard let indexPath = eventsTableView.indexPathForRow(at: point) else {
            fatalError("can't find point in tableView") }
        notifiers.remove(at: indexPath.row)
        eventsTableView.reloadData()
        
        if notifiers[indexPath.row].userData is Activity {
            let activity = notifiers[indexPath.row].userData as! Activity
            activity.practiceCancelled()
            if let nextActivity = activitySet.nextActivity(){
                scheduleActivity(nextActivity)
            }
        } else if notifiers[indexPath.row].userData is [Treatment] {
            
        }
    }
    
    // MARK: - ActivitySetDelegate
    
    func activityAdded(at: Int) {
        let activity = Factory.sharedData.patient.activitySet[at]
        let notifier = Notifier(title : "Nouvelle activité : " + activity.name, shortTopic : "Consultez l'app pour plus d'informations", fullBody : activity.description, activity)
        notifier.displayOn(date: Calendar.current.date(byAdding: DateComponents(minute : 1), to: Date())!, controller : self)
    }
    
    func activityUpdated(at: Int) {
        
    }
    
    func activityRemoved(at: Int) {
        
    }
    
    func activityAlreadyExist() {
        
    }
    
    func errorDataBaseRead() {
        
    }
    
    func errorDataBaseWrite() {
        
    }
    
}

