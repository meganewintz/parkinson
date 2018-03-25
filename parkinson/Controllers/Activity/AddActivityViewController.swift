//
//  AddActivityViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 24/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    var activityController : ActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let controller = self.childViewControllers.first as? ActivityViewController else{
            return
        }
        self.activityController = controller

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
