//
//  ViewController.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import UIKit

class ViewController: BaseViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var downloadButton: UIButton!
	@IBOutlet weak var titleLabel: UILabel!
	
	private let videoViewModel: VideoViewModel
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindingWithViewModel()
		setupView()
		
	}
	
	required init?(coder: NSCoder) {
		self.videoViewModel = VideoViewModelImp(videoSeriving: VideoServices())
		super.init(coder: coder)
	}
	
	
	private func setupView() {
		tableViewSetup()
		titleLabel.isHidden = true
		downloadButton.isHidden = true
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
		
		self.videoViewModel.reloadTableView?.bind {[weak self] driveVideo in
			guard let self = self else { return }
			self.handleRefresh(data: driveVideo)
		}
	}
	
	private func handleRefresh(data: DriveVideo?) {
		self.tableView.reloadData()
		if let video = data {
			self.titleLabel.text = video.title
		}
	}
	
	private func tableViewSetup() {
		tableView.register(UINib(nibName: VideoItemCell.reuseableIdentifier, bundle: nibBundle), forCellReuseIdentifier: VideoItemCell.reuseableIdentifier)
		tableView.delegate = self
		tableView.dataSource = self
		tableView.separatorColor = .clear
	}

	
	// MARK: - Actions
	@IBAction func didTapDownload(_ sender: Any) {
		
	}
}



// MARK: - UITableViewDataSource, UITableViewDelegate
extension ViewController: UITableViewDataSource, UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		self.videoViewModel.numberOfRow()
	}
	
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let viewModel = videoViewModel.viewModelForRow(at: indexPath)
		let cell = VideoItemCell.dequeue(tableView: tableView)
		cell.configure(item: viewModel)
		return cell
	}
}

