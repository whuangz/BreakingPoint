//
//  GroupFeedCell.swift
//  BreakingPoint
//
//  Created by William Huang on 24/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class GroupFeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var msgContentLbl: UILabel!

    func configureCell(img: UIImage, email: String, content: String){
        self.profileImg.image = img
        self.emailLbl.text = email
        self.msgContentLbl.text = content
    }

}
