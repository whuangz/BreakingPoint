//
//  AuthService.swift
//  BreakingPoint
//
//  Created by William Huang on 05/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import Foundation
import Firebase

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email:String, andPassword pwd: String, userCreationComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().createUser(withEmail: email, password: pwd) { (user, error) in
            if error == nil {
                let userData = [
                    "provider" : user?.providerID,
                    "email" : user?.email
                ]
                DataService.instance.createUserDB(uid: (user?.uid)!, data: userData)
                userCreationComplete(true, nil)
            }else{
                print("Registration failed")
                userCreationComplete(false, error)
            }
        }
    }
    
    func loginUser(withEmail email:String, andPassword pwd:String, loginComplete: @escaping (_ status: Bool, _ error: Error?) -> ()){
        Auth.auth().signIn(withEmail: email, password: pwd) { (user, error) in
            if error != nil {
                loginComplete(false, nil)
                return
            }
            
            loginComplete(true, nil)
        }
    }
}
