//
//  EventTableViewCell.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-04-27.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var infoView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.contentView.layer.borderWidth = 1.0
        
        self.infoView.layer.zPosition = 1
    }
}
