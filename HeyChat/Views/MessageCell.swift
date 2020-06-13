//
//  MessageCell.swift
//  HeyChat
//
//  Created by Aman Ilyasovich on 6/13/20.
//  Copyright © 2020 Aman Ilyasovich. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBubble: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cAvatar: UIImageView!
    @IBOutlet weak var aAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}