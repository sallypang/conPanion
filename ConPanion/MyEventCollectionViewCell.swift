//
//  MyEventTableViewCell.swift
//  ConPanion
//
//  Created by Sally Pang on 2016-05-02.
//  Copyright © 2016 Sally Pang. All rights reserved.
//

import UIKit

class MyEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor(netHex: 0xffffff).CGColor
        self.layer.borderWidth = 3.0
    }

}
