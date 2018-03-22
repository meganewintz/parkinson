//
//  AddActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 19/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController, FrequenceActivityViewControllerDelegate {

    let activities = Factory.sharedData.patient.activitySet
    var dateFormatter = DateFormatter()
    var test = "It's ok"
    var frequencies = [Event]()

    @IBOutlet weak var descrTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDateFormatter()
        self.createEvents()
        
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions -
    
    // action when we click on the validate Button
    @IBAction func validerButton(_ sender: Any) {
        print(test)
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
        self.saveActivity(withName: nameToSave, withDescr: descrToSave, withFreq: getEnableFrequencies(frequencies:self.frequencies))
        _ = navigationController?.popViewController(animated: true)

    }
    

        
        // MARK: - Activity Data Management -
        
    func saveActivity(withName name: String, withDescr descr: String, withFreq frequencies: [Event]) {
        activities.addActivity(activity: Activity(name: name, description: descr, frequencies: frequencies))
    }
    
    // MARK: - Delegate -
    
    func updateActivityFrenquencies(frequencies: [Event]) {
        self.test = frequencies[0].title
        self.frequencies = frequencies
        print("ici")
        for fre in frequencies {
            print(fre.title, fre.enable)
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
    // Used to send the data frequencies already choose
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "frequencyChoiceSegue" {
            let frequenceVC = segue.destination as! FrequenceActivityViewController
            frequenceVC.delegate = self
            frequenceVC.frequencies = self.frequencies
            
        }
    }
    
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
    
    func createEvents() { // called in viewDidLoad()
        let event1 = Event(title: "Lundi", time: dateFormatter.date(from: "14:00")!)
        let event2 = Event(title: "Mardi", time: dateFormatter.date(from: "14:00")!)
        let event3 = Event(title: "Mercredi", time: dateFormatter.date(from: "14:00")!)
        let event4 = Event(title: "Jeudi", time: dateFormatter.date(from: "14:00")!)
        let event5 = Event(title: "Vendredi", time: dateFormatter.date(from: "14:00")!)
        let event6 = Event(title: "Samedi", time: dateFormatter.date(from: "14:00")!)
        let event7 = Event(title: "Dimanche", time: dateFormatter.date(from: "14:00")!)
        
        self.frequencies.append(event1)
        self.frequencies.append(event2)
        self.frequencies.append(event3)
        self.frequencies.append(event4)
        self.frequencies.append(event5)
        self.frequencies.append(event6)
        self.frequencies.append(event7)
    }
    
    func setDateFormatter() { // called in viewDidLoad()
        self.dateFormatter.dateFormat = "HH:mm"
    }
    
    
    func alert(message: String, userInfo user: String = "") {
        let alert = UIAlertController(title: message,
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
