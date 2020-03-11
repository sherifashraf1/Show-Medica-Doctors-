//
//  ApiUrl.swift
//  Medica
//
//  Created by Sherif on 3/4/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation
import Alamofire
struct MedicaURL {
    static let drsUrl = "http://medicahealthy.net/api/institutions"
    static let registerUrl = "http://medicahealthy.net/api/auth-client/register"
    static let loginUrl    = "http://medicahealthy.net/api/auth-client/login"
    
   static let drsUrlParams : [String : String] = [
        "lat" : "31.222229",
        "lng" : "29.949358"
    ]
    static  let drsUrlHeaders : HTTPHeaders = [
        "Content-Type" : "text/plain",
        "Accept" : "application/json",
        "From"   : "c213348c8e34e7dd",
        "User-Agent" : "android",
        "Accept-Language" : "en"
    ]
}
