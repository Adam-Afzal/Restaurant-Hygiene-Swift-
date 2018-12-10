//
//  RatingTableViewCell.swift
//  HygieneApp
//
//  Created by Adam Afzal on 26/03/2018.
//  Copyright © 2018 Adam Afzal. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var restname: UIImageView!
    @IBOutlet weak var restnamelabel: UILabel!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
