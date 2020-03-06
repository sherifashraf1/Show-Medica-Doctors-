//
//  MapFactory.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation
import UIKit
struct MapFfactory {
    static func makeMapWithNavigate() -> UINavigationController{
        let vc = MapKitVC()
        return UINavigationController(rootViewController: vc)
}
}
