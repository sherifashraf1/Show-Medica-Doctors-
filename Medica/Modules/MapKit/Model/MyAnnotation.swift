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
    var title : String?
    var institutionTitle : String
    var annotDescription : String
    var specialty, price : String
    var address : String
    var image: String
    var coordinate : CLLocationCoordinate2D
    
    
    init(title: String,
         institutionTitle: String,
         annotDescription: String,
         specialty: String,
         price: String,
         address: String,
         image: String ,
         coordinate : CLLocationCoordinate2D
        )
    {
        self.title = title
        self.institutionTitle = institutionTitle
        self.annotDescription = annotDescription
        self.specialty = specialty
        self.price = price
        self.address = address
        self.image = image
        self.coordinate = coordinate
        super.init()
    }
}
