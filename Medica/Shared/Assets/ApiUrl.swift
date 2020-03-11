//
//  ApiUrl.swift
//  Medica
//
//  Created by Sherif on 3/4/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation
import Alamofire
struct MyURL {
    static let drsUrl = "http://medicahealthy.net/api/institutions"
    static let registerUrl = "http://medicahealthy.net/api/auth-client/register"
    static let loginUrl    = "http://medicahealthy.net/api/auth-client/login"
    
   static let params : [String : String] = [
        "lat" : "31.222229",
        "lng" : "29.949358"
    ]
    static  let headers : HTTPHeaders = [
        "Content-Type" : "text/plain",
        "Accept" : "application/json",
        "From"   : "c213348c8e34e7dd",
        "User-Agent" : "android",
        "Accept-Language" : "en"
    ]
}
