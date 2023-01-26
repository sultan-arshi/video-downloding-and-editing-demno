//
//  DequeueInitializable.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation
import UIKit

protocol DequeueInitializable {
	static var reuseableIdentifier: String { get }
}

extension DequeueInitializable where Self: UITableViewCell {
	
	static var reuseableIdentifier: String {
		return String(describing: Self.self)
	}
	
	static func dequeue(tableView: UITableView) -> Self {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseableIdentifier) else {
			return UITableViewCell() as! Self
		}
		return cell as! Self
	}
	
}

