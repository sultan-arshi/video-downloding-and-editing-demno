//
//  ApiClient.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import UIKit

import Foundation
protocol ApiService {
	func performRequest<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void)
}

class APIClient {
	private let session = URLSession(configuration: .default)
	private func fetchFeed(request : URLRequest?, completion:@escaping (Result<Data, AppError>) -> Void) {
		
		guard let req = request else {
			let error = AppError(error: "Not a valid Request")
			completion(.failure(error))
			return
		}
		
		let task = session.dataTask(with: req) { data, response, error in
			if let data = data {
				completion(.success(data))
			} else if let error = error {
				completion(.failure(AppError.init(error: error.localizedDescription)))
			}
		}
		task.resume()
	}
}

extension APIClient:ApiService {
	public func performRequest<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void) {
		
		if !Reachability.isConnectedToNetwork() {
			completionHandler(.failure(AppError(error: "Network is Busy")))
			return
		}
		
		self.fetchFeed(request: router.urlRequest()) { result in
			switch result {
			case .success(let data):
				if let stringData = String(data: data, encoding: .utf8) {
					print("debugPring dataRecived: ", stringData)
				} else {
					print("debugPring data could not be conveted into String")
				}
				do {
					let decode = try JSONDecoder().decode(T.self, from: data)
					completionHandler(.success(decode))
				} catch let error {
					print("debugPring Got Error",error)
					completionHandler(.failure(AppError(error:error.localizedDescription)))
				}
			case .failure(let error):
				completionHandler(.failure(error))
			}
		}
	}
}
