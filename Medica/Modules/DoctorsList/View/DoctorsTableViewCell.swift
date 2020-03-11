//
//  DoctorsTableViewCell.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit

class DoctorsTableViewCell: UITableViewCell {
    enum DoctorInformationType {
        case drName
    }
    
    @IBOutlet weak var drName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func recieveDoctorInfo(type : DoctorInformationType , text : String?){
        switch type {
        case .drName:
            drName.text = text ?? ""
        }
    }
}
