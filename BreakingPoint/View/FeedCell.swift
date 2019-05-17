//
//  FeedCell.swift
//  BreakingPoint
//
//  Created by William Huang on 16/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class FeedCell: UITableViewCell {

    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var messageContent: UILabel!
    
    func configureCell(img: UIImage, email: String, msg: String){
        profileImg.image = img
        emailLbl.text = email
        messageContent.text = msg
    }
}
