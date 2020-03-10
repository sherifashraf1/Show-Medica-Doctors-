//
//  ActivityIndicator + extension.swift
//  Medica
//
//  Created by Sherif on 3/10/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
extension UIActivityIndicatorView {
    func scaleIndicator(factor: CGFloat) {
        transform = CGAffineTransform(scaleX: factor, y: factor)
    }
}
