//
//  ViewController.swift
//  parkinson
//
//  Created by Thierry WINTZ on 11/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var dataTab = [Notifier]()
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let notifier = Notifier(title : "Vous avez un message", shortTopic : "Consultez l'app pour plus d'informations", fullBody : "Ce message constitue un premier test\nde l'affichage des notifications sur l'écran d'accueil", nil)
        notifier.displayOn(date: Calendar.current.date(byAdding: DateComponents(minute : 1), to: Date())!, controller : self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func addEvent(timer : Timer){
        dataTab.append(timer.userInfo as! Notifier)
        eventsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataTab.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventCell
        cell.titleLabel.text = dataTab[indexPath.row].title
        cell.bodyLabel.text = dataTab[indexPath.row].fullBody
        return cell
    }
}

