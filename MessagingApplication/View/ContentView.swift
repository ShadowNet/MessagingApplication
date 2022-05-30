//
//  ContentView.swift
//  MessagingApplication
//
//  Created by Redghy on 5/28/22.
//

import Foundation
import UIKit

class ContentCell: UITableViewCell {

    @IBOutlet weak var youImage: UIImageView!
    @IBOutlet weak var contentBubble: UIView!
    @IBOutlet weak var contentImage: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentBubble.layer.cornerRadius = contentBubble.frame.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
