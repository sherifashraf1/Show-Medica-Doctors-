//
//  DoctorDetailsVC.swift
//  Medica
//
//  Created by Sherif on 3/5/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit

class DoctorDetailsVC: UIViewController {
    @IBOutlet weak var doctorName: UILabel!
    @IBOutlet weak var doctorAddress: UILabel!
    @IBOutlet weak var doctorInstitution: UILabel!
    @IBOutlet weak var doctorDescription: UILabel!
    @IBOutlet weak var doctorSpeciality: UILabel!
    @IBOutlet weak var doctorPrice: UILabel!
    var drName = ""
    var drAddress = ""
    var drInstitution = ""
    var drDescription = ""
    var drSpeciality = ""
    var drPrice = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dragUpView()
        dragDownView()
        doctorName.text = drName
        doctorAddress.text = drAddress
        doctorInstitution.text = drInstitution
        doctorDescription.text = drDescription
        doctorSpeciality.text = drSpeciality
        doctorPrice.text = drPrice
    }
    
    func dragUpView(){
        let slideUp = UISwipeGestureRecognizer(target: self, action: #selector(dragViewFromTop(gesture:)))
        slideUp.direction = .up
        view.addGestureRecognizer(slideUp)
    }
    
    func dragDownView(){
        let slideDown = UISwipeGestureRecognizer(target: self, action: #selector(dragViewFromBottom(gesture:)))
        slideDown.direction = .down
        view.addGestureRecognizer(slideDown)
    }
    
    @objc func dragViewFromBottom(gesture: UISwipeGestureRecognizer) {
        if let window = UIApplication.shared.keyWindow { // keyWindow is the main window that receive an event , in this case it receive the gesture
            gesture.view?.frame = CGRect(x:window.frame.width  , y: window.frame.height  , width: 5 , height: 5)
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromBottom
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false,
                         completion: {
                            self.view.removeFromSuperview()
            })
        }
    }
    
    @objc func dragViewFromTop(gesture: UISwipeGestureRecognizer) {
        if let window = UIApplication.shared.keyWindow { // keyWindow is the main window that receive an event , in this case it receive the gesture
            gesture.view?.frame = CGRect(x:window.frame.width  , y: window.frame.height  , width: 5 , height: 5)
            let transition: CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.reveal
            transition.subtype = CATransitionSubtype.fromTop
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false,
                         completion: {
                            self.view.removeFromSuperview()
            })
        }
    }
}
