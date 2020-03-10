//
//  RegisterVC.swift
//  Medica
//
//  Created by Sherif on 3/4/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit
import Alamofire
import Toast_Swift
class RegisterVC: UIViewController {
    @IBOutlet weak var userNameTxtF: UITextField!
    @IBOutlet weak var phoneNumberTxtF: UITextField!
    @IBOutlet weak var emailTxtF: UITextField!
    @IBOutlet weak var passwordTxtF: UITextField!
    @IBOutlet weak var confirmPasswordTxtF: UITextField!
    @IBOutlet weak var passBtn: UIButton!
    @IBOutlet weak var confirmPassBtn: UIButton!
    
    fileprivate func setRightImageOnTextFields() {
        userNameTxtF.setRightImage(imageName: "username-icon")
        phoneNumberTxtF.setRightImage(imageName: "phone")
        emailTxtF.setRightImage(imageName: "email-icon")
        passwordTxtF.setRightImage(imageName: "lock")
        confirmPasswordTxtF.setRightImage(imageName: "lock")
    }
    
    fileprivate func checkPassAndConfirmPassEqually() {
        passwordTxtF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        confirmPasswordTxtF.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
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
        userNameTxtF.text = ""
        phoneNumberTxtF.text = ""
        emailTxtF.text = ""
        passwordTxtF.text = ""
        confirmPasswordTxtF.text = ""
        passwordTxtF.setRightImage(imageName: "lock")
        confirmPasswordTxtF.setRightImage(imageName: "lock")
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRightImageOnTextFields()
        checkPassAndConfirmPassEqually()
        passBtn.setImage(UIImage(named: "eye"), for: .selected)
        confirmPassBtn.setImage(UIImage(named: "eye"), for: .selected)
    }

    @objc func textFieldDidChange(_ textField: UITextField){
        // if we start typing in the confirm password textfield
        guard let passwordTxtF = passwordTxtF.text else {return }
        
        if passwordTxtF.isEmpty{
            confirmPasswordTxtF.text = ""
            self.passwordTxtF.setRightImage(imageName: "lock")
            self.confirmPasswordTxtF.setRightImage(imageName: "lock")
        }
        if self.passwordTxtF.text == confirmPasswordTxtF.text && passwordTxtF != ""{
            self.passwordTxtF.setRightImage(imageName: "unlock")
            confirmPasswordTxtF.setRightImage(imageName: "unlock")
        } else {
            self.passwordTxtF.setRightImage(imageName: "lock")
            self.confirmPasswordTxtF.setRightImage(imageName: "lock")
        }
    }
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        
        if userNameTxtF.text != "" && emailTxtF.text != "" && phoneNumberTxtF.text != "" && passwordTxtF.text != "" && confirmPasswordTxtF.text != "" {
            //TODO call API
            let vc = MapFfactory.makeMapWithNavigate()
            present(vc, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Data Required", message: "Please Enter all Fields!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
   
    @IBAction func editUserDidPressed(_ sender: Any) {
        userNameTxtF.becomeFirstResponder()
    }
    
    @IBAction func editPhoneDidPressed(_ sender: Any) {
        phoneNumberTxtF.becomeFirstResponder()
    }
    
    @IBAction func editEmailDidPressed(_ sender: Any) {
        emailTxtF.becomeFirstResponder()
    }
    @IBAction func showPasswordDidPressed(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        passwordTxtF.becomeFirstResponder()
        self.passwordTxtF.isSecureTextEntry = !passwordTxtF.isSecureTextEntry
    }
    
    @IBAction func showConfirmPassDidPressed(_ sender: UIButton) {
        
        confirmPasswordTxtF.becomeFirstResponder()
        self.confirmPasswordTxtF.isSecureTextEntry = !confirmPasswordTxtF.isSecureTextEntry
        sender.isSelected = !sender.isSelected
        
    }
    
    
    
    @IBAction func backBtnDidPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signFromHereDidPressed(_ sender: Any) {
        let vc = LoginVC()
        present(vc, animated: true, completion: nil)
    }
    
    
}

