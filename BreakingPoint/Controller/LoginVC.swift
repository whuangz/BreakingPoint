//
//  LoginVC.swift
//  BreakingPoint
//
//  Created by William Huang on 05/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailTxt: InsetTextField!
    @IBOutlet weak var pwdTxt: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTxt.delegate = self
        pwdTxt.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signInBtnPressed(_ sender: Any) {
        if emailTxt.text != nil && pwdTxt.text != nil {
            AuthService.instance.registerUser(withEmail: emailTxt.text!, andPassword: pwdTxt.text!, userCreationComplete: { (success, loginErr) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }else{
                    print(String(describing: loginErr?.localizedDescription))
                }
                
                AuthService.instance.registerUser(withEmail: self.emailTxt.text!, andPassword: self.pwdTxt.text!, userCreationComplete: { (success, registerErr) in
                    if success{
                        AuthService.instance.loginUser(withEmail: self.emailTxt.text!, andPassword: self.pwdTxt.text!, loginComplete: { (success, nil) in
                            self.dismiss(animated: true, completion: nil)
                            print("Successfully Registered User")
                        })
                    }else{
                        print(String(describing: registerErr?.localizedDescription))
                    }
                })
            })
        }
    }
    
}


extension LoginVC : UITextFieldDelegate {
    
}
