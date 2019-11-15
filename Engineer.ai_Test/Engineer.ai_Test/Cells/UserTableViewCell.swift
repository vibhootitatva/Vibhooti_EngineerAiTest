//
//  UserTableViewCell.swift
//  Engineer.ai_Test
//
//  Created by MAC99 on 11/15/19.
//  Copyright © 2019 MAC99. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imvUserImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       self.imvUserImage.layer.cornerRadius =  self.imvUserImage.bounds.size.width / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
