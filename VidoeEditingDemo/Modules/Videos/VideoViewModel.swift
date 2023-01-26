//
//  VideoViewModel.swift
//  VidoeEditingDemo
//
//  Created by Rashdan Natiq on 26/01/2023.
//

import Foundation

protocol VideoViewModel {
	var isLoading : Binder<Bool> { get }
}


class VideoViewModelImp: VideoViewModel {
	
	
	// MARK: - VideoViewModel
	var isLoading: Binder<Bool> = Binder(false)
	
	// MARK: - private
	private var videoSerives: VideoServicing
	private var driveVidoe: DriveVideo?
	
	

	// MARK: - dependency Indection
	init(videoSeriving: VideoServices) {
		self.videoSerives = videoSeriving
		self.getVideos()
	}
	
	
	
}

// MARK: - Helper
extension VideoViewModelImp {
	private func getVideos() {
		self.videoSerives.getVideos(driveId: "21e5e7da-faa1-45db-820d-60266796fd9a") { [weak self] result in
			guard let self = self else { return }
			self.isLoading.value = false
			self.handleResponse(resonse: result)
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
		
	}
}
