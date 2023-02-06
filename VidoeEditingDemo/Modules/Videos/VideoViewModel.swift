//
//  VideoViewModel.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation
import UIKit

protocol VideoViewModel {
	var isLoading: Binder<Bool> { get }
	var reloadTableView: Binder<DriveVideo?>? { get }
	var playVidoe: Binder<NSData?> { get }
	
	func numberOfRow() -> Int
	func viewModelForRow(at indexPath: IndexPath) -> VideoItemCellViewModel
	func downloadVideo()
}


class VideoViewModelImp: VideoViewModel {

	// MARK: - VideoViewModel
	var isLoading: Binder<Bool> = Binder(false)
	var reloadTableView: Binder<DriveVideo?>? = Binder(nil)
	var playVidoe: Binder<NSData?> = Binder(nil)
	
	func numberOfRow() -> Int {
		self.itemViewModels.count
	}
	
	func viewModelForRow(at indexPath: IndexPath) -> VideoItemCellViewModel {
		return self.itemViewModels[indexPath.row]
	}
	
	func downloadVideo() {
		if let video = self.driveVidoe {
			self.downloadVideo(driveVideo: video)
		}
	}
	
	// MARK: - private
	private var videoSerives: VideoServicing
	private var driveVidoe: DriveVideo?
	private var itemViewModels: [VideoItemCellViewModel] = [] {
		didSet {
			reloadTableView!.set(to: driveVidoe)
		}
	}
	
	

	// MARK: - dependency Indection
	init(videoSeriving: VideoServices) {
		self.videoSerives = videoSeriving
		self.getVideos()
	}
	
	
	
}

// MARK: - Helper
extension VideoViewModelImp {
	private func getVideos() {
		self.isLoading.value = true
		self.videoSerives.getVideos(driveId: "21e5e7da-faa1-45db-820d-60266796fd9a") { [weak self] result in
			DispatchQueue.main.async {
				guard let self = self else { return }
				self.isLoading.value = false
				self.handleResponse(resonse: result)
			}
		}
	}
	
	private func handleResponse(resonse: Result<DriveVideo, AppError>) {
		switch resonse {
			
		case .success(let driveVideo):
			self.driveVidoe = driveVideo
			self.bindValues()
			self.createViewModels()
		case .failure(let error):
			print(error.localizedDescription)
		}
	}
	
	private func bindValues() {
		
	}
	
	private func createViewModels() {
		if let model = self.driveVidoe {
			itemViewModels = model.items.map({ VideoItemCellViewModelImp(item: $0) })
		}
	}
	
	private func downloadVideo(driveVideo: DriveVideo) {
		self.isLoading.value = true
		self.videoSerives.downloadVideo(url: driveVideo.videoUrl) {[weak self] data in
			DispatchQueue.main.async {
				guard let self = self else { return }
				self.isLoading.value = false
				self.playVidoe.value = data
			}
		} failure: { error in
			DispatchQueue.main.async {
				self.isLoading.value = false
				print("Errror: ", error.localizedDescription)
			}
		}

	}
}
