//
//  DoseTableViewCell.swift
//  parkinson
//
//  Created by Thierry WINTZ on 26/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class DoseTableViewCell: UITableViewCell {


    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var comprLabel: UILabel!
    
    @IBOutlet weak var hourLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func stepperAction(_ sender: UIStepper) {
        if sender.value == 1 {
            quantityLabel.text = String(sender.value)
            comprLabel.text = "comprimé"
        }
        else {
            quantityLabel.text = String(sender.value)
            comprLabel.text = "comprimés"
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
