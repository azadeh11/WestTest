//
//  InfoTableViewCell.swift
//  westTest
//
//  Created by Azadeh on 7/31/18.
//  Copyright © 2018 Azadeh. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {


    @IBOutlet var myView: UIView!
    @IBOutlet var imageInfo: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
