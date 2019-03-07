//
//  postCell.swift
//  parstagram
//
//  Created by Osama Soliman on 3/7/19.
//  Copyright © 2019 Osama Soliman. All rights reserved.
//

import UIKit

class postCell: UITableViewCell {
    
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var uerNameLable: UILabel!
    @IBOutlet weak var captionLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
