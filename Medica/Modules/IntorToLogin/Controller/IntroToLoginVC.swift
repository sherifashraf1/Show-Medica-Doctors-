//
//  IntroToLoginVC.swift
//  Medica
//
//  Created by Sherif on 3/3/20.
//  Copyright © 2020 Sherif. All rights reserved.
//

import UIKit

class IntroToLoginVC: UIViewController {

    @IBOutlet weak var loginBtn: RoundedButton!
    @IBOutlet weak var signupBtn: RoundedButton!
    
    @IBOutlet weak var medicaCardBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.moveImageLeftTextCenter(image: UIImage(named: "login-icon")!, imagePadding: 30.0, renderingMode: .alwaysOriginal)
        signupBtn.moveImageLeftTextCenter(image: UIImage(named: "signup-icon")!, imagePadding: 30.0, renderingMode: .alwaysOriginal)
        medicaCardBtn.moveImageLeftTextCenter(image: UIImage(named: "medica")!, imagePadding: 30.0, renderingMode: .alwaysOriginal)
        medicaCardBtn.imageView?.tintColor = .white

    }
    @IBAction func loginDidPressed(_ sender: Any) {
        let vc = LoginVC()
        present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func signUpDidPressed(_ sender: Any) {
        let vc = RegisterVC()
        present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
}
