//
//  ViewController.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import UIKit

class ViewController: BaseViewController {

	@IBOutlet weak var tableView: UITableView!
	
	private let videoViewModel: VideoViewModel
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindingWithViewModel()
		registerCell()
		
	}
	
	required init?(coder: NSCoder) {
		self.videoViewModel = VideoViewModelImp(videoSeriving: VideoServices())
		super.init(coder: coder)
	}
	
	private func bindingWithViewModel() {
		self.videoViewModel.isLoading.bind { [weak self] (isLoading) in
			guard let self = self else { return }
			if isLoading {
				self.showActivityIndicator()
			} else {
				self.hideActivityIndicator()
			}
		}
		
		self.videoViewModel.reloadTableView?.bind {[weak self] _ in
			guard let self = self else { return }
			self.tableView.reloadData()
		}
	}
	
	private func registerCell() {
		tableView.register(VideoItemCell.self, forCellReuseIdentifier: VideoItemCell.reuseableIdentifier)
	}
	
	

}

