//
//  UserCell.swift
//  BreakingPoint
//
//  Created by William Huang on 18/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    
    @IBOutlet weak var profileImg: CircleImage!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var whitemarkCheck: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        whitemarkCheck.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            whitemarkCheck.isHidden = false
        }else{
            whitemarkCheck.isHidden = true
        }
    }
    
    func configureCell(profileImg img: UIImage, email: String ){
        self.profileImg.image = img
        self.emailLbl.text = email
        
    }
}
