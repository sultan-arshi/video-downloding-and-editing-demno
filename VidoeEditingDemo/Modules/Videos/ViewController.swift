//
//  ViewController.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import UIKit
import Photos
import AVFoundation
import AVKit

class ViewController: BaseViewController {

	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var downloadButton: UIButton! {
		didSet {
			downloadButton.layer.cornerRadius = 5
			downloadButton.layer.borderColor = UIColor.black.cgColor
			downloadButton.layer.borderWidth = 1
		}
	}
	@IBOutlet weak var titleLabel: UILabel!
	
	private let videoViewModel: VideoViewModel
	
	override func viewDidLoad() {
		super.viewDidLoad()
		bindingWithViewModel()
		setupView()
//		let loadedPlayer = VideoEditor.startEditing()
//		let playerViewController = AVPlayerViewController()
//		playerViewController.player = loadedPlayer
//		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//			self.present(playerViewController, animated: true, completion: {
//				loadedPlayer.play()
//			})
//		})
		
		VideoEditor.startEditing()
	}
	
	required init?(coder: NSCoder) {
		self.videoViewModel = VideoViewModelImp(videoSeriving: VideoServices())
		super.init(coder: coder)
	}
	
	
	private func setupView() {
		tableViewSetup()
		titleLabel.isHidden = true
		downloadButton.isHidden = true
		tableView.isHidden = true
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
		
		self.videoViewModel.playVidoe.bind {[weak self] data in
			guard let self = self, let data = data else { return }
			guard var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
			url.appendPathComponent("video.mp4") // or whatever extension the video is
			do {
				try data.write(to: url) // assuming video is of Data type
			} catch let errr {
				print(errr)
			}
			let player = AVPlayer(url: url)
			let playerViewController = AVPlayerViewController()
			playerViewController.player = player
			self.present(playerViewController, animated: true) {
				playerViewController.player!.play()
			}
			PHPhotoLibrary.shared().performChanges({
				PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: url)
			}) { saved, error in
				if saved {
					let alertController = UIAlertController(title: "Your video was successfully saved", message: nil, preferredStyle: .alert)
					let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
					alertController.addAction(defaultAction)
					self.present(alertController, animated: true, completion: nil)
				}
			}
		}
	}
	
	private func handleRefresh(data: DriveVideo?) {
		self.tableView.reloadData()
		if let video = data {
			titleLabel.isHidden = false
			downloadButton.isHidden = false
			tableView.isHidden = false
			self.titleLabel.text = "Video Title: "  + video.title
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
		videoViewModel.downloadVideo()
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

