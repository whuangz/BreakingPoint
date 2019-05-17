//
//  GroupCell.swift
//  BreakingPoint
//
//  Created by William Huang on 23/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupTitleLbl: UILabel!
    @IBOutlet weak var groupDescLbl: UILabel!
    @IBOutlet weak var memberCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(title: String, desc: String, memberCount: Int){
        self.groupTitleLbl.text = title
        self.groupDescLbl.text = desc
        self.memberCountLbl.text = "\(memberCount) members."
    }

}
