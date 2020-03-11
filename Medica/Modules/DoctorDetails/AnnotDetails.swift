//
//  AnnotDetails.swift
//  Medica
//
//  Created by Sherif on 3/10/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit

class AnnotDetails: UIViewController {
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var doctorCoord: UILabel!
    var drName = ""
    var drAddres = ""
    var lat = 0.0
    var lon = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doctorName.text = drName
        doctorAddress.text = drAddres
        doctorCoord.text = "\(lat) , \(lon)"
        dragUpView()
        dragDownView()
    }
}

