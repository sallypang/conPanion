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
    @IBOutlet weak var goToSiteButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.contentView.layer.borderWidth = 1.0
        
        self.infoView.layer.zPosition = 1
        self.infoView.backgroundColor = UIColor(netHex: 0x80b0f7)
        self.goToSiteButton.layer.zPosition = 2
        self.goToSiteButton.layer.masksToBounds = true
        self.goToSiteButton.layer.cornerRadius = self.goToSiteButton.bounds.width / 2.0
        self.goToSiteButton.backgroundColor = UIColor(netHex: 0x5DB96F)
    }
}
