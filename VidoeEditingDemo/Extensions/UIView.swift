//
//  UIView.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation
import UIKit


public extension UIView
{
	static func loadFromXib<T>(withOwner: Any? = nil, options: [UINib.OptionsKey : Any]? = nil) -> T where T: UIView
	{
		let bundle = Bundle(for: self)
		let nib = UINib(nibName: "\(self)", bundle: bundle)

		guard let view = nib.instantiate(withOwner: withOwner, options: options).first as? T else {
			fatalError("Could not load view from nib file.")
		}
		return view
	}
}
