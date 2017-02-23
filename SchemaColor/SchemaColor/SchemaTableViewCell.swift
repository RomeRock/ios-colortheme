//
//  SchemaTableViewCell.swift
//  SchemaColor
//
//  Created by Rome Rock on 2/22/17.
//  Copyright © 2017 Rome Rock. All rights reserved.
//

import UIKit

class SchemaTableViewCell: UITableViewCell {

    @IBOutlet var selectedView: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var previewLabel: UILabel!
    @IBOutlet var previewButton: UIButton!
    @IBOutlet var circleView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        circleView.makeCircular()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        selectedView.isHidden = !selected
        
        // Configure the view for the selected state
    }

}
