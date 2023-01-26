//
//  VideoItemCell.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import UIKit

class VideoItemCell: UITableViewCell, DequeueInitializable {

	@IBOutlet weak var container: UIView!
	@IBOutlet weak var detailText: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
