//
//  ViewController.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 25/01/2023.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	private let videoViewModel: VideoViewModel
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	required init?(coder: NSCoder) {
		self.videoViewModel = VideoViewModelImp(videoSeriving: VideoServices())
		super.init(coder: coder)
	}
	

}

