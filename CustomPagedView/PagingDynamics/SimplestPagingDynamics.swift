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
	
	var dragInitialScrollAmount: CGFloat?
	
	mutating func startDrag(gestureState: DragGesture.Value) {
		dragInitialScrollAmount = scrollAmount
	}
	mutating func update(gestureState: DragGesture.Value?) {
		guard
			let gestureState,
			let dragInitialScrollAmount
		else { return }
		
		// When finger moves, offset pages along with it
		scrollAmount = dragInitialScrollAmount + gestureState.translation.width
	}
	mutating func endDrag(gestureState: DragGesture.Value) {
		dragInitialScrollAmount = nil
	}
	
	static var name = "Simplest"
}
