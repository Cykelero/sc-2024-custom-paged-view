//
//  SimplestPagingDynamics.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-13.
//

import Foundation
import SwiftUI

struct SimplestPagingDynamics: PagingDynamics {
	var scrollAmount: CGFloat = 0
	
	mutating func startDrag(gestureState: DragGesture.Value) {
		// TODO
	}
	mutating func update(gestureState: DragGesture.Value?) {
		// TODO
	}
	mutating func endDrag(gestureState: DragGesture.Value) {
		// TODO
	}
	
	static var name = "Simplest"
}
