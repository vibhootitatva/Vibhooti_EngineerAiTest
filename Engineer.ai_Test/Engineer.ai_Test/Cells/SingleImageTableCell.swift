//
//  SingleImageTableCell.swift
//  Engineer.ai_Test
//
//  Created by MAC99 on 11/15/19.
//  Copyright © 2019 MAC99. All rights reserved.
//

import UIKit

class SingleImageTableCell: UITableViewCell {

    @IBOutlet weak var imvItemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
