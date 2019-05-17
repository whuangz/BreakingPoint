//
//  SecondViewController.swift
//  BreakingPoint
//
//  Created by William Huang on 31/07/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class GroupVC: UIViewController {

    
    @IBOutlet weak var groupsTableView: UITableView!
    
    var groupsArray = [Group]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupsTableView.delegate = self
        groupsTableView.dataSource = self
        retriveGroups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        retriveGroups()
    }
    
    
    func retriveGroups(){
        DataService.instance.getAllGroups { (returnedGroups) in
            self.groupsArray = returnedGroups
            self.groupsTableView.reloadData()
        }
    }
}

extension GroupVC : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell {
            let group = groupsArray[indexPath.row]
            cell.configureCell(title: group.groupTitle, desc: group.groupDesc, memberCount: group.members.count)
            return cell
        }else{
            return GroupCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsArray.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "groupFeedVC") as? GroupFeedVC else {return}
        let group = groupsArray[indexPath.row]
        groupFeedVC.initData(forGroup: group)
        presentDetail(groupFeedVC)
    }
}

