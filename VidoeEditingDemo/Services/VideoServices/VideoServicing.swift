import Foundation
typealias ServiceResult<T> = (Result<T, AppError>) -> Void

protocol VideoServicing {
	func getVideos<T: Decodable>(driveId: String, completion: @escaping ServiceResult<T>)
	func downloadVideo(url: String, completion: @escaping (NSData) -> Void, failure: @escaping (AppError) -> Void)
}
