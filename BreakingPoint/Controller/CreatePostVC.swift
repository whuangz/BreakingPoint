//
//  CreatePostVC.swift
//  BreakingPoint
//
//  Created by William Huang on 15/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var txtField: UITextView!
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtField.delegate = self
        sendBtn.bindToKeyboard()
        sendBtn.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.profileImg.image = UIImage.init(named: "defaultProfileImage")
        self.emailLbl.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if txtField.text != nil {
            DataService.instance.uploadPost(withMsg: txtField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, sendComplete: { (success) in
                if success{
                    self.sendBtn.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                    print("Successfully Uploaded")
                }else{
                    self.sendBtn.isEnabled = true
                    print("there was an error")
                }
            })
        }
    }
}

extension CreatePostVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        txtField.text = ""
    }
}
