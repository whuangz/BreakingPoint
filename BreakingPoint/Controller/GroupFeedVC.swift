//
//  GroupFeedVC.swift
//  BreakingPoint
//
//  Created by William Huang on 24/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit
import Firebase

class GroupFeedVC: UIViewController {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var groupFeedTableView: UITableView!
    @IBOutlet weak var sendBtnView: UIView!
    @IBOutlet weak var msgTxtField: InsetTextField!
    @IBOutlet weak var sendBtn: UIButton!
    
    var group: Group?
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendBtnView.bindToKeyboard()
        sendBtn.isEnabled = false
        
        groupFeedTableView.dataSource = self
        groupFeedTableView.delegate = self
        
        msgTxtField.delegate = self
        msgTxtField.addTarget(self, action: #selector(self.editingChanged), for: .editingChanged)
        retrieveMessages()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupTitleLbl.text = group?.groupTitle
        DataService.instance.getEmailForGroup(group: group!) { (returnedEmails) in
            self.membersLbl.text = returnedEmails.joined(separator: ", ")
        }
        retrieveMessages()
    }
    
    func retrieveMessages(){
        DataService.instance.GROUP_REF.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesForGroup(group: self.group!, handler: { (messages) in
                self.messages = messages.reversed()
                self.groupFeedTableView.reloadData()
                
                if self.messages.count > 0 {
                    self.groupFeedTableView.scrollToRow(at: IndexPath.init(row: self.messages.count - 1, section: 0), at: .none, animated: true)
                }
            })
        }
    }
    
    func initData(forGroup group: Group){
        self.group = group
    }

    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        if msgTxtField.text != "" {
            msgTxtField.isEnabled = false
            sendBtn.isEnabled = false
            DataService.instance.uploadPost(withMsg: msgTxtField.text!, forUID: (Auth.auth().currentUser?.uid)!, withGroupKey: group?.groupKey, sendComplete: { (success) in
                if success {
                    self.msgTxtField.text = ""
                    self.msgTxtField.isEnabled = true
                    self.sendBtn.isEnabled = true
                    print("Message sended")
                }
            })
        }
    }
    
    @objc func editingChanged(){
        if msgTxtField.text != "" {
            sendBtn.isEnabled = true
        }else{
            sendBtn.isEnabled = false
        }
    }

}

extension GroupFeedVC : UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? GroupFeedCell{
            let msg = messages[indexPath.row]
            DataService.instance.getUserName(forUid: msg.sender_id, handler: { (returnedUserName) in
                cell.configureCell(img: UIImage.init(named: "defaultProfileImage")!, email: returnedUserName, content: msg.content)
            })
            return cell
        } else{
            return GroupFeedCell()
        }
    }
}
