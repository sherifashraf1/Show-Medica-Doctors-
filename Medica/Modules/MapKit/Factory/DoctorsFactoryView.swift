//
//  DoctorsFactoryView.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation

import Foundation
import UIKit
struct DoctorsFactoryView {
    static func makeDoctorsLisWithNavigate() -> UINavigationController{
        let vc = DoctorsListTableVC()
        return UINavigationController(rootViewController: vc)
    }
}
