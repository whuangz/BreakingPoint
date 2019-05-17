//
//  MeVC.swift
//  BreakingPoint
//
//  Created by William Huang on 15/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {

    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.emailLbl.text = Auth.auth().currentUser?.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        let logoutPopOut = UIAlertController.init(title: "Logout?", message: "Are you sure want to logout?", preferredStyle: UIAlertControllerStyle.actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(withIdentifier: "authVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }catch {
                print(error.localizedDescription)
            }
        }
        
        logoutPopOut.addAction(logoutAction)
        present(logoutPopOut, animated: true, completion: nil)
    }
    
  
}
