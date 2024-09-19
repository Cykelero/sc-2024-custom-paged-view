//
//  WithSnappingPagingDynamics.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-13.
//

import Foundation
import SwiftUI

struct WithSnappingPagingDynamics: PagingDynamics {
	var pageWidth: CGFloat = 0
	
	var scrollAmount: CGFloat = 0
	
	var dragInitialScrollAmount: CGFloat?
	
	mutating func startDrag(gestureState: DragGesture.Value) {
		dragInitialScrollAmount = scrollAmount
	}
	mutating func update(gestureState: DragGesture.Value?) {
		if
			let gestureState,
			let dragInitialScrollAmount
		{
			// User is dragging: offset pages
			scrollAmount = dragInitialScrollAmount + gestureState.translation.width
		} else {
			// User is not dragging: snap to closest page
			let closestPageIndex = ((-scrollAmount) / pageWidth).rounded()
			let closestPageScrollAmount = closestPageIndex * -pageWidth
			scrollAmount += (closestPageScrollAmount - scrollAmount) / 8
		}
	}
	mutating func endDrag(gestureState: DragGesture.Value) {
		dragInitialScrollAmount = nil
	}

	static var name = "With snapping"
}
