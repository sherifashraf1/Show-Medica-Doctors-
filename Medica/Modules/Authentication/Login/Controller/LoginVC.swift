//
//  LoginVC.swift
//  Medica
//
//  Created by Sherif on 3/3/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    @IBOutlet weak var phoneNumberTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var passBtn: UIButton!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // listen for keyboard events
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardWillChange(notification : Notification){
        if notification.name == UIResponder.keyboardWillShowNotification ||
            notification.name == UIResponder.keyboardWillChangeFrameNotification {
            view.frame.origin.y = -60
        } else {
            view.frame.origin.y = 0
            
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        phoneNumberTxtF.text = ""
        passwordTxtF.text = ""
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumberTxtF.setLeftImage(imageName: "phone-icon")
        passwordTxtF.setLeftImage(imageName: "pass-icon")
        passBtn.setImage(UIImage(named: "eye"), for: .selected)
    }
    @IBAction func editButtonDidPressed(_ sender: Any) {
        phoneNumberTxtF.becomeFirstResponder()
        passwordTxtF.resignFirstResponder()
    }
    
    @IBAction func eyeButtonDidPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxtF.becomeFirstResponder()
        phoneNumberTxtF.resignFirstResponder()
        self.passwordTxtF.isSecureTextEntry = !self.passwordTxtF.isSecureTextEntry
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        let vc = RegisterVC()
        present(vc, animated: true, completion: nil)

    }
    
    @IBAction func loginDidPressed(_ sender: Any) {
        let vc = MapFfactory.makeMapWithNavigate()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backBtnDidPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetPassFromHereDidPressed(_ sender: Any) {
        ///TODO
    }

    @IBAction func guestDidPressed(_ sender: Any) {
        
        let vc = MapFfactory.makeMapWithNavigate()
        present(vc, animated: true, completion: nil)
    }

}
