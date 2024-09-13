//
//  PagingDynamics.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-13.
//

import Foundation
import SwiftUI

protocol PagingDynamics {
	var scrollAmount: CGFloat { get }
	
	init()
	mutating func startDrag(gestureState: DragGesture.Value)
	mutating func update(gestureState: DragGesture.Value?)
	mutating func endDrag(gestureState: DragGesture.Value)
	
	static var name: String { get }
}
