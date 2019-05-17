//
//  RoundedImage.swift
//  BreakingPoint
//
//  Created by William Huang on 15/08/18.
//  Copyright © 2018 William Huang. All rights reserved.
//

import UIKit

class CircleImage: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = self.layer.frame.width / 2
        self.clipsToBounds = true
    }

}
