//
//  URLRequestConvertible.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import Foundation
struct ProductionServer {
	static var host = "prod.drivefocus-api.com/api/v1"
	// for testing only
	static let accessToken = "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJlZjY0ZTg2Yy1lNmY5LTRiN2MtOTRhNC0yMGFiMzJlMGU3NzUiLCJpYXQiOjE2NzQ3NDQzMjIsImV4cCI6MTY3NDc0NzkyMiwidHlwIjoiYWNjZXNzIiwicm9sIjoiVVNFUiJ9.Oy9bcXhsCe2pr953wmgI6zctq3DXbHfUB399dnf4pr-xUMvRFRy55rEaMskC35BS9F0hYivyP2xJyAzUkGJbIQ"
}

public protocol URLRequestConvertible {
	func urlRequest()  -> URLRequest?
}
enum VideosNetworkRouter<T>: URLRequestConvertible {
	
	case getVideo(T)
	
	private var scheme: String {
		switch self {
		case .getVideo:
			return "https"
		}
	}

	private var host: String {
		switch self {
		case .getVideo:
			return ProductionServer.host
		}
	}
	
	private var path: String {
		switch self {
		case .getVideo(let params):
			 let request = params as! ViedeoServiceRequest
			 return  "/drives/\(request.driveId)/videos"
		}
	}
	
	private var method: String {
		switch self {
		case .getVideo:
			return "GET"
		}
	}

	func urlRequest() -> URLRequest? {
		var components = URLComponents()
		components.scheme = self.scheme
		components.host = self.host
		components.path = self.path
		
//		guard let url = components.url else {
//			assert(true,"url not formed")
//			return nil
//		}
		var urlRequest = URLRequest(url: URL(string: "https://prod.drivefocus-api.com/api/v1/drives/21e5e7da-faa1-45db-820d-60266796fd9a/videos")!)
		urlRequest.httpMethod = self.method
		
		urlRequest.addValue(ProductionServer.accessToken, forHTTPHeaderField: "Authorization")
		urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
		
		return urlRequest
	}
}
