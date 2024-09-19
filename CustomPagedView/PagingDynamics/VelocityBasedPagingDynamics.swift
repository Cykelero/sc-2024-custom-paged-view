//
//  VelocityBasedPagingDynamics.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-19.
//

import Foundation
import SwiftUI

struct VelocityBasedPagingDynamics: PagingDynamics {
	var pageWidth: CGFloat = 0
	
	var scrollAmount: CGFloat = 0
	
	var dragInitialScrollAmount: CGFloat?
	var targetPageIndex: Int?
	
	mutating func startDrag(gestureState: DragGesture.Value) {
		targetPageIndex = nil
		
		dragInitialScrollAmount = scrollAmount
	}
	mutating func update(gestureState: DragGesture.Value?) {
		if
			let gestureState,
			let dragInitialScrollAmount
		{
			// User is dragging: offset pages
			scrollAmount = dragInitialScrollAmount + gestureState.translation.width
		} else if
			let targetPageIndex
		{
			// User is not dragging: snap to chosen page
			let closestPageScrollAmount = CGFloat(targetPageIndex) * -pageWidth
			scrollAmount += (closestPageScrollAmount - scrollAmount) / 8
		}
	}
	mutating func endDrag(gestureState: DragGesture.Value) {
		dragInitialScrollAmount = nil
		
		// Drag is ending: choose which page to snap to
		let closestPageIndex = Int(((-scrollAmount) / pageWidth).rounded())
		let xSpeed = gestureState.velocity.width
		
		if xSpeed > 0 {
			targetPageIndex = closestPageIndex - 1
		} else if xSpeed < 0 {
			targetPageIndex = closestPageIndex + 1
		} else {
			// Oops: in practice, this code is never executed, for two reasons
			// 1. Most importantly: A user will never remove their finger from the screen at zero velocity! We're inprecise, and there's always some unintended motion.
			// 2. But also, for some reason, the DragGesture's state doesn't take into account moments of (relative) stillness. So if you move your finger quickly and then leave it in place for a couple of seconds, then finally remove it from the screen, the reported velocity will still be very high, instead of near-zero.
			//    So for the comparison, you'd need to decrease the velocity based on how much time has passed in the last gesture state change. (the last time the finger moved)
			targetPageIndex = closestPageIndex
		}
	}

	static var name = "Velocity-based"
}
