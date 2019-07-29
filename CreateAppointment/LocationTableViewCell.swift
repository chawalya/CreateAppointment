//
//  LocationTableViewCell.swift
//  CreateAppointment
//
//  Created by Patchariya Piyaaromrat on 25/7/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import UIKit

class LocationTableViewCell: UITableViewCell {
    @IBOutlet weak var myLocationNameLabel: UILabel!
    @IBOutlet weak var myLocationLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureLocationCell(locationName: String, location: String) {
    self.myLocationNameLabel.text = locationName
    self.myLocationLabel.text = location
    }

}
