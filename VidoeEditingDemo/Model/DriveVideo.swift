//
//  DriveVideo.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import Foundation

// MARK: - DriveVideo
struct DriveVideo: Codable {
	let id, title: String
	let videoUrl: String
	let items: [Item]
	let driveId: String
}

// MARK: - Item
struct Item: Codable {
	let id: String
	let points: Int
	let videoID, title, type, priority: String
	let markup: [Markup]

	enum CodingKeys: String, CodingKey {
		case id, points
		case videoID = "videoId"
		case title, type, priority, markup
	}
}

// MARK: - Markup
struct Markup: Codable {
	let id, videoItemID: String
	let momentOnVideo: Int
	let x1, y1, x2, y2: Double

	enum CodingKeys: String, CodingKey {
		case id
		case videoItemID = "videoItemId"
		case momentOnVideo, x1, y1, x2, y2
	}
}
