//
//  MyAnnotation.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation
import MapKit

class MyAnnotation : NSObject , MKAnnotation {
    let title : String?
    let locationName : String
    let discipline : String
    let coordinate : CLLocationCoordinate2D
    
    init(title : String , locationName : String , discipline : String , coordinate : CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        super.init()
    }
    var subTitle : String? {
        return locationName
    }
}
