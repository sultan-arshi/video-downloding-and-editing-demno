//
//  VideoCellViewModel.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation

protocol VideoItemCellViewModel {
	var detailsText: Binder<String>{ get }
}

class VideoItemCellViewModelImp: VideoItemCellViewModel {
	
	var detailsText: Binder<String> = Binder("")
	
	init(item: Item) {
		detailsText.value = "Title: \(item.title) \nType: \(item.type) \nPriority: \(item.priority) \nPoints: \(item.points) \nMarksups: \(item.markup.count)"
	}
	
	
}
