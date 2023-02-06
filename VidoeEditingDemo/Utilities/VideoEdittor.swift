//
//  VideoEdittor.swift
//  VidoeEditingDemo
//
//  Created by Rashdan Natiq on 01/02/2023.
//

import Foundation
import AVFoundation
import UIKit

class VideoEditor: NSObject {
	
	static func startEditing()  {
		// Step 1: Load the video asset
		//		let path = Bundle.main.path(forResource: "sampleVideo", ofType: "mp4")
		//		let videoURL = URL(filePath: path!)
		//		let videoAsset = AVAsset(url: videoURL)
		//
		//		// Step 2: Create a mutable composition
		//		let composition = AVMutableComposition()
		//
		//		// Step 3: Add the video track to the composition
		//		let videoTrack = videoAsset.tracks(withMediaType: .video).first
		//		let compositionVideoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
		//		try? compositionVideoTrack?.insertTimeRange(CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration), of: videoTrack!, at: CMTime.zero)
		//
		//		// Step 4: Create a video composition layer instruction
		//		let videoCompositionLayerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: compositionVideoTrack!)
		//
		//		// Step 5: Create a video composition instruction
		//		let videoCompositionInstruction = AVMutableVideoCompositionInstruction()
		//		videoCompositionInstruction.timeRange = CMTimeRangeMake(start: CMTime.zero, duration: videoAsset.duration)
		//		videoCompositionInstruction.layerInstructions = [videoCompositionLayerInstruction]
		//
		//		// Step 6: Add the instruction to the composition
		//		let videoComposition = AVMutableVideoComposition()
		//		videoComposition.instructions = [videoCompositionInstruction]
		//		videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
		//		videoComposition.renderSize = videoTrack!.naturalSize
		//
		//		// Step 7: Add the image overlay to the video composition
		//		let image = UIImage(named: "Image")!
		//		let imageLayer = CALayer()
		//		imageLayer.contents = image.cgImage
		//		imageLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)
		//
		//		let parentLayer = CALayer()
		//		let videoLayer = CALayer()
		//		parentLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)
		//		videoLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)
		//		parentLayer.addSublayer(videoLayer)
		//		parentLayer.addSublayer(imageLayer)
		//
		//
		//		videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayers: [videoLayer], in: parentLayer) //AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: imageLayer, in: videoComposition.lay)
		//
		//		// Step 8: Export the composition to a new video file
		//		let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
		//		exportSession?.videoComposition = videoComposition
		//		exportSession?.outputURL = URL(fileURLWithPath: "path/to/output.mp4")
		//		exportSession?.exportAsynchronously {
		//			// Handle export completion
		//		}
		
		//		let playerItem = AVPlayerItem(asset: composition)
		//		playerItem.videoComposition = videoComposition
		//		let player = AVPlayer(playerItem: playerItem)
		//		return player
		
		
		let path = Bundle.main.path(forResource: "sampleVideo", ofType: "mp4")
		let videoURL = URL(filePath: path!)
		let asset = AVAsset(url: videoURL)
		let image = UIImage(named: "Image")!
		let fileManager = FileManager.default
		let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
		let outputURL = documentsDirectory.appendingPathComponent("output.mp4")

		let composition = AVMutableComposition()
		let videoTrack = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
		try! videoTrack?.insertTimeRange(CMTimeRangeMake(start: .zero, duration: asset.duration), of: asset.tracks(withMediaType: .video)[0], at: .zero)

		let videoComposition = AVMutableVideoComposition()
		videoComposition.frameDuration = CMTimeMake(value: 1, timescale: 30)
		videoComposition.renderSize = asset.tracks(withMediaType: .video).first!.naturalSize

		let imageLayer = CALayer()
		imageLayer.contents = image.cgImage
		imageLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)

		let parentLayer = CALayer()
		let videoLayer = CALayer()
		parentLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)
		videoLayer.frame = CGRect(x: 0, y: 0, width: videoComposition.renderSize.width, height: videoComposition.renderSize.height)
		parentLayer.addSublayer(videoLayer)
		parentLayer.addSublayer(imageLayer)

		videoComposition.animationTool = AVVideoCompositionCoreAnimationTool(postProcessingAsVideoLayer: videoLayer, in: parentLayer)

		let instruction = AVMutableVideoCompositionInstruction()
		instruction.timeRange = CMTimeRangeMake(start: CMTimeMakeWithSeconds(5, preferredTimescale: 30), duration: CMTimeMakeWithSeconds(2, preferredTimescale: 30))

		let layerInstruction = AVMutableVideoCompositionLayerInstruction(assetTrack: videoTrack!)
		layerInstruction.setOpacityRamp(fromStartOpacity: 0.0, toEndOpacity: 1.0, timeRange: instruction.timeRange)

		instruction.layerInstructions = [layerInstruction]
		videoComposition.instructions = [instruction]
		let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
		exportSession?.videoComposition = videoComposition
		exportSession?.outputFileType = AVFileType.mp4
		exportSession?.outputURL = outputURL
		exportSession?.exportAsynchronously {
			// handle export completion
			switch exportSession!.status {
			case .completed:
				print("Video export completed: \(outputURL)")
			case .failed:
				print("Video export failed: \(String(describing: exportSession?.error))")
			default:
				break
			}
		}
		
	}
	
}
