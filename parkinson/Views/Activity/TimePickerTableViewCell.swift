//
//  TimePickerTableViewCell.swift
//  parkinson
//
//  Created by Thierry WINTZ on 17/03/2018.
//  Copyright © 2018 Mégane WINTZ. All rights reserved.
//

import UIKit

class TimePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
