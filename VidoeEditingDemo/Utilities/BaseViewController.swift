//
//  BaseViewController.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation
import UIKit


class BaseViewController: UIViewController {
	
	private lazy var activityIndicator: UIActivityIndicatorView = {
		let activity = UIActivityIndicatorView()
		activity.translatesAutoresizingMaskIntoConstraints = false
		activity.style = .large
		return activity
	}()
	
	
	func showActivityIndicator() {
		self.view.addSubview(self.activityIndicator)
		self.activityIndicator
			.centerInSuperView()
		self.activityIndicator.startAnimating()
	}
	
	
	func hideActivityIndicator() {
		self.activityIndicator.stopAnimating()
		self.activityIndicator.removeFromSuperview()
	}
	
}
