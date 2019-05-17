//
//  FirstViewController.swift
//  BreakingPoint
//
//  Created by William Huang on 31/07/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class FeedVC: UIViewController {

    @IBOutlet weak var feedTableView: UITableView!
    var messages = [Message]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        retrieveMessages()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        retrieveMessages()
    }
    
    func retrieveMessages(){
        DataService.instance.getAllMessages { (messages) in
            self.messages = messages.reversed()
            self.feedTableView.reloadData()
        }
    }


}

extension FeedVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as? FeedCell{
            let msg = messages[indexPath.row]
            let img = UIImage.init(named: "defaultProfileImage")!
            
            DataService.instance.getUserName(forUid: msg.sender_id, handler: { (returnUserName) in
                cell.configureCell(img: img, email: returnUserName, msg: msg.content)
            })
            
            
            return cell
        }else{
            return UITableViewCell()
        }
    }
}
