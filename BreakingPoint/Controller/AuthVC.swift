//
//  AuthVC.swift
//  BreakingPoint
//
//  Created by William Huang on 05/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit
import Firebase

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser != nil {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func fbSignInPressed(_ sender: Any) {
    }
    
    @IBAction func googleSignInPressed(_ sender: Any) {
    }
    
    @IBAction func emailSignInPressed(_ sender: Any) {
        if let loginVC = storyboard?.instantiateViewController(withIdentifier: "loginVC") as? LoginVC {
            present(loginVC, animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
