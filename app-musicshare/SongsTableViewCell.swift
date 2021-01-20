//
//  SongsTableViewCell.swift
//  app-musicshare
//
//  Created by Joseph Abi Rached on 20/01/2021.
//

import UIKit

class SongsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var songImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
