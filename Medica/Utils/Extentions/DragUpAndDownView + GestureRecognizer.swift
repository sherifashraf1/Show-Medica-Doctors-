//
//  DragUpAndDownView + GestureRecognizer.swift
//  Medica
//
//  Created by Sherif on 3/11/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
extension UIViewController {
    func dismissViewFromUp(){
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(dragView(gesture:)))
        slideUp.direction = .up
        view.addGestureRecognizer(slideUp)
    }
    func dismissViewFromDown(){
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dragView(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    
    @objc func dragView(gesture: UISwipeGestureRecognizer) {
        if let window = UIApplication.shared.keyWindow { // keyWindow is the main window that receive an event , in this case it receive the gesture
            gesture.view?.frame = CGRect(x:window.frame.width  , y: window.frame.height  , width: 5 , height: 5)
            let transition: CATransition = CATransition()
            
            switch gesture.direction {
            case UISwipeGestureRecognizer.Direction.down:
                transition.subtype = CATransitionSubtype.fromBottom
            case UISwipeGestureRecognizer.Direction.up:
                transition.subtype = CATransitionSubtype.fromTop
            default:
                break
            }
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false,
                         completion: {
                            self.view.removeFromSuperview()
            })
        }
    }
    
}

