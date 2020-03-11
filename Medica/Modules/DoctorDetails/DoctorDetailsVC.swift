//
//  DoctorDetailsVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
class DoctorDetailsVC: UIViewController {
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var doctorInstitution: UILabel!
    @IBOutlet weak var doctorDescription: UILabel!
    @IBOutlet weak var doctorSpeciality: UILabel!
    @IBOutlet weak var doctorPrice: UILabel!
    
    var drName = ""
    var drAddress = ""
    var drInstitution = ""
    var drDescription = ""
    var drSpeciality = ""
    var drPrice = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorName.text = drName
        doctorAddress.text = drAddress
        doctorInstitution.text = drInstitution
        doctorDescription.text = drDescription
        doctorSpeciality.text = drSpeciality
        doctorPrice.text = drPrice
        dismissViewFromUp()
        dismissViewFromDown()
    }
}
