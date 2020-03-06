//
//  Extension Button + TextField.swift
//  Medica
//
//  Created by Sherif on 3/4/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func moveImageLeftTextCenter(image : UIImage, imagePadding: CGFloat, renderingMode: UIImage.RenderingMode){
        self.setImage(image.withRenderingMode(renderingMode), for: .normal)
        guard let imageViewWidth = self.imageView?.frame.width else{return}
        guard let titleLabelWidth = self.titleLabel?.intrinsicContentSize.width else{return}
        self.contentHorizontalAlignment = .left
        let imageLeft = imagePadding - imageViewWidth / 2
        let titleLeft = (bounds.width - titleLabelWidth) / 2 - imageViewWidth - 10
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: imageLeft, bottom: 0.0, right: 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleLeft , bottom: 0.0, right: 0.0)
    }
    
}

extension UITextField{
    
    func setLeftImage(imageName:String) {
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        imageView.image = UIImage(named: imageName)
        self.leftView = imageView;
        self.leftViewMode = .always
    }
    
    func setRightImage(imageName:String) {
        
        let imageView = UIImageView(frame: CGRect(x: -5, y: -5, width: 25, height: 25))
        imageView.image = UIImage(named: imageName)
        self.rightView = imageView;
        self.rightViewMode = .always
    }
    
}

