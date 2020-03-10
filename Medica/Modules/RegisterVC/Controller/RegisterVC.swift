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
    
    
    var reachability : Reachability?
    
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
            //apiCalling()
            
            let vc = MapFfactory.makeMapWithNavigate()
            present(vc, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Data Required", message: "Please Enter all Fields!!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
    func apiCalling () {
        do{
            try self.reachability = Reachability.init()
        } catch {
            debugPrint(error.localizedDescription)
        }
        if ((reachability!.connection) != .unavailable) {
            self.view.makeToastActivity(.center)
            let params = [
                "name" : self.userNameTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines) as AnyObject,
                "email" : self.emailTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines) as! AnyObject,
                "mobile" : self.phoneNumberTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines) as! AnyObject,
                "password" : self.passwordTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines) as! AnyObject,
                "password_confirmation" : self.confirmPasswordTxtF.text!.trimmingCharacters(in: .whitespacesAndNewlines) as! AnyObject
            ]
            let headers : HTTPHeaders = [
                "Content-Type" : "application/x-www-form-urlencoded",
                "Authorizations" : "token",
                "Accept" : "application/json",
                "User-Agent" : "iphone",
                "Accept-Language" : "ar"
            ]
            
            let encodeURL = StaticAPIsUrls.apiRegisterUrl.rawValue
            let request = AF.request(encodeURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers, interceptor: nil)
            request.responseJSON { (response) in
                print(response.request!)
                print(response.result)
                print(response.response )
                
                switch response.result {
                case .success(let payload):
                    self.view.hideAllToasts()
                    if let payload = payload as? Dictionary<String , AnyObject> {
                        print(payload)
                        let resultValue = payload as NSDictionary
                        let code = resultValue["result"] as! String
                        let message = resultValue["message"] as! String
                        
                        if code == "1" {
                            let data = resultValue["data"] as! NSDictionary
//                            let token = resultValue["token"] as! String
//                            let userId = data["id"] as! Int
                            
//                            UserDefaults.standard.set(userId, forKey: "UserId")
//                            UserDefaults.standard.set("\(token)", forKey: "Authorizations")
                            
                        } else {
                            let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
                            let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                            alert.addAction(action)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                case .failure(let error):
                    debugPrint(error.localizedDescription)
                    
                    let alert = UIAlertController(title: "Error", message: "App cannot connect to server!!", preferredStyle: .alert)
                    let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                }
               
            }
            
        }else {
            let alert = UIAlertController(title: "Connection Error", message: "Please check your internet connection..!!", preferredStyle: .alert)
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

