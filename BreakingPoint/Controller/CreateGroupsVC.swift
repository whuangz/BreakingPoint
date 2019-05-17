//
//  CreateGroupsVC.swift
//  BreakingPoint
//
//  Created by William Huang on 18/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit
import Firebase

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var titleTxt: InsetTextField!
    @IBOutlet weak var descTxt: InsetTextField!
    @IBOutlet weak var emailSearchTxt: InsetTextField!
    @IBOutlet weak var groupMemberLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneBtn: UIButton!
    
    var emailArrays = [String]()
    var choosenUserArrays = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        emailSearchTxt.delegate = self
        emailSearchTxt.addTarget(self, action: #selector(self.textFieldDIdChanged), for: .editingChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneBtn.isHidden = true
    }
    
    @objc func textFieldDIdChanged(){
        if emailSearchTxt.text == "" {
            emailArrays = []
            tableView.reloadData()
        }else{
            DataService.instance.getEmail(forSearchQuery: emailSearchTxt.text!, handler: { (returnedEmailArray) in
                self.emailArrays = returnedEmailArray
                self.tableView.reloadData()
            })
        }
        
    }

    @IBAction func closeBtnPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneBtnPressed(_ sender: Any) {
        if titleTxt.text != "" && descTxt.text != "" {
            DataService.instance.getIds(forEmailNames: choosenUserArrays, handler: { (idsArray) in
                var ids: [String] = idsArray
                ids.append((Auth.auth().currentUser?.uid)!)
                
                DataService.instance.createGroup(forTitle: self.titleTxt.text!, forDesc: self.descTxt.text!, forUserIds: ids, sendComplete: { (success) in
                    if success{
                        print("Group Created")
                        self.dismiss(animated: true, completion: nil)
                    }
                })
            })
        }
    }
    
}

extension CreateGroupsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        if !choosenUserArrays.contains(cell.emailLbl.text!) {
            choosenUserArrays.append(cell.emailLbl.text!)
            groupMemberLbl.text = choosenUserArrays.joined(separator: ", ")
        }else{
            choosenUserArrays = choosenUserArrays.filter({ $0 != cell.emailLbl.text!})
        }
        
        if choosenUserArrays.count > 1 {
            groupMemberLbl.text = choosenUserArrays.joined(separator: ", ")
            doneBtn.isHidden = false
        }else{
            groupMemberLbl.text = "add people to your group"
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emailArrays.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell {
            let profileImg = UIImage.init(named: "defaultProfileImage")!
            let email = emailArrays[indexPath.row]
            cell.configureCell(profileImg: profileImg, email: email)
            return cell
        }else {
            return UITableViewCell()
        }
    }
}

extension CreateGroupsVC: UITextFieldDelegate{
    
}
