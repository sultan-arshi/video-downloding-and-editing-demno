//
//  Binder.swift
//  VidoeEditingDemo
//
//  Created by Sultan Ali on 26/01/2023.
//

import Foundation

class Binder<T> {
	typealias BinderListener = (T) -> Void
	
	var listener: BinderListener?
	var value: T {
		didSet {
			self.listener?(self.value)
		}
	}
	
	func bind(_ listener: @escaping BinderListener) {
		self.listener = listener
		self.listener?(self.value)
	}
	
	func set(to value: T) {
		self.value = value
	}
	
	init(_ value: T) {
		self.value = value
	}
}
