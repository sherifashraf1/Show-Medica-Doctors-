//
//  RoundedViews.swift
//  Medica
//
//  Created by Sherif on 3/3/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
class  RoundedButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.orange.cgColor
    }
}

class  RoundedButtonNoBorderColor: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 20
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
    }
}

class RoundedView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
}
