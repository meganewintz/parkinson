//
//  AddActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 19/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    let activities = Factory.sharedData.patient.activitySet
    
    @IBOutlet weak var descrTextView: UITextView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
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
        self.saveActivity(withName: nameToSave, withDescr: descrToSave)
        _ = navigationController?.popViewController(animated: true)

    }
    
        
        // MARK: - Activity Data Management -
        
    func saveActivity(withName name: String, withDescr descr: String) {
        activities.addActivity(activity: Activity(name: name, description: descr))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Utilities -
    
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
