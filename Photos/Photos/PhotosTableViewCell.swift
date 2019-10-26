//
//  PhotosTableViewCell.swift
//  Photos
//
//  Created by Cassidy Pelchat on 10/25/19.
//  Copyright © 2019 Cassidy Pelchat. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    @IBOutlet weak var photoTitleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
