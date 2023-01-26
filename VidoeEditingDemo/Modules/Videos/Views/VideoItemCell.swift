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
	
	
	private var itemViewModel: VideoItemCellViewModel?
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		backgroundColor = UIColor.clear
		
		self.container.layer.borderWidth = 1
		self.container.layer.cornerRadius = 5
		self.container.layer.borderColor = UIColor.clear.cgColor
		self.container.layer.masksToBounds = true
		
		self.layer.shadowOpacity = 0.2
		self.layer.shadowOffset = CGSize(width: 0, height: 2)
		self.layer.shadowRadius = 2
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.masksToBounds = false
	}
	
	func configure(item: VideoItemCellViewModel) {
		self.itemViewModel = item
		self.bind()
	}
    
}


// MARK: - private
private extension VideoItemCell {
	
	func bind() {
		if let item = self.itemViewModel {
			item.detailsText.bind { value in
				self.detailText.text = value
			}
		}
	}
	
}

