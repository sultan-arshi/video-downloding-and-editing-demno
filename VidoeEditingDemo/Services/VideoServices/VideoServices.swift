import Foundation
class VideoServices: VideoServicing {
	
	private let apiConvertible:ApiService = APIClient()
	
	func getVideos<T>(driveId: String, completion: @escaping ServiceResult<T>) where T : Decodable {
		
		let request = ViedeoServiceRequest(driveId: driveId)
		let router = VideosNetworkRouter.getVideo(request)
		apiConvertible.performRequest(router: router) { (result:Result<DriveVideo, AppError>) in
			
			switch result{
			case .failure(let error):
				completion(.failure(error))
			case .success(let data):
				completion(.success(data as! T))
				
			}
		}
	}
}
