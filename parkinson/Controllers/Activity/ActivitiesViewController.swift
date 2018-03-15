//
//  ActivitiesViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 12/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    let factory: Factory = Factory()
    var tableViewController: ActivitiesTableViewController!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.displayActivities()
        self.tableViewController = ActivitiesTableViewController(tableView: self.tableView, activities: self.factory.activitySet)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        let alert = UIAlertController(title: "Nouvelle activité",
                                      message: "Ajouter un nom",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Ajouter",
                                       style: .default)
        {
            [unowned self] action in
            guard let nameTextField = alert.textFields?.first,
                let nameToSave = nameTextField.text else{
                    return
            }
            self.saveActivity(withName: nameToSave, withDescr: "Ok")
            //self.factory.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Annuler",
                                         style: .default)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    // MARK: - Activity Data Management -
    
    func saveActivity(withName name: String, withDescr descr: String) {
        guard let error = factory.saveActivity(withName: name, withDescr: descr) else{
            return
        }
        // if there is an error during the load of the data, display the error
        self.alertError(errorMsg: error[0], userInfo: error[1])
    }
    
    /// Delete an activity
    ///
    /// - Precondition: index must be into bound of collection
    /// - Parameter index: <#index description#>
    /// - Returns: <#return value description#>
    func deleteActivity(activityWithIndex index: Int) {
        guard let error = factory.deleteActivity(activityWithIndex: index) else{
            let indexPath = IndexPath(row: index, section: 0) // assuming cell is for first or only section of table view
            tableViewController.activityRemoved(at: indexPath)
            return
        }
        // if there is an error during the load of the data, display the error
        self.alertError(errorMsg: error[0], userInfo: error[1])
    }
    
    /// Display the activities present in the CoreData or an error if there is.
    func displayActivities() {
        guard let error = factory.loadActivities()  else{
            return
        }
        // if there is an error during the load of the data, display the error
        self.alertError(errorMsg: error[0], userInfo: error[1])
    }
    
    // MARK: - Utilities -
    
    func alertError(errorMsg error: String, userInfo user: String = "") {
        let alert = UIAlertController(title: error,
                                      message: user,
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ok ",
                                         style: .default)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
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
