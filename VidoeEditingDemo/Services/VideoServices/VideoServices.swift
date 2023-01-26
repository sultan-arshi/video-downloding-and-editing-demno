import Foundation
class VideoServices: VideoServicing {
	
	private let apiConvertible:ApiService = APIClient()
	
	func getVideos<T>(driveId: String, completion: @escaping ServiceResult<T>) where T : Decodable {
		
		let request = ViedeoServiceRequest(driveId: driveId)
		let router = VideosNetworkRouter.getVideo(request)
		apiConvertible.performRequest(router: router) { (result:Result<DriveVideo, AppError>) in
			
			switch result {
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				completion(.success(data as! T))
				
			}
		}
	}
	
	func downloadVideo(url: String, completion: @escaping (NSData) -> Void, failure: @escaping (AppError) -> Void) {
		DispatchQueue.global(qos: .background).async {
			if let url = URL(string: url) {
				if let urlData = NSData(contentsOf: url) {
					completion(urlData)
				} else {
					failure(AppError(error: "Video could not be downloded"))
				}
			} else {
				failure(AppError(error: "URL is not correct"))
			}
		}
	}
}
