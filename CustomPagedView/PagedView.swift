//
//  PagedView.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-13.
//

import SwiftUI

struct PagedView: View {
	let updateTimer = Timer.publish(every: 1 / 120, on: .main, in: .common).autoconnect()
	
	@State var dynamics: any PagingDynamics
	@State var dragGestureState: DragGesture.Value?
	
    var body: some View {
		Canvas { context, size in
			let pageLayoutSize = size
			let pageVisualPadding: CGFloat = 35
			
			func visualRect(ofPageAtIndex pageIndex: Int) -> CGRect {
				CGRect(
					origin: CGPoint(
						x: dynamics.scrollAmount + CGFloat(pageIndex) * pageLayoutSize.width,
						y: 0
					),
					size: pageLayoutSize
				)
				.insetBy(dx: pageVisualPadding, dy: pageVisualPadding)
			}
			
			let pagesToRenderInfoList =
				(0...).lazy
				.map {
					(index: $0, visualRect: visualRect(ofPageAtIndex: $0))
				}
				.prefix { $0.visualRect.minX <= size.width }
			
			for pageToRenderInfo in pagesToRenderInfoList {
				let currentPagePath = Path(
					roundedRect: pageToRenderInfo.visualRect,
					cornerSize: CGSize(width: 60, height: 60)
				)
				
				// Draw page background
				context.fill(currentPagePath, with: .color(.accentColor))
				
				// Draw page number
				let pageNumberCenter = CGPoint(x: pageToRenderInfo.visualRect.midX, y: pageToRenderInfo.visualRect.midY - 20)
				
				// // Background circle
				context.fill(
					Path(
						ellipseIn:
							CGRect(origin: pageNumberCenter, size: .zero)
							.insetBy(dx: -45, dy: -45)
					),
					with: .color(.white)
				)
				
				// // Number
				let pageNumberText =
				Text(String(pageToRenderInfo.index + 1))
					.foregroundStyle(Color.accentColor)
					.font(.system(size: 70, weight: .bold, design: .rounded))
				let resolvedPageNumberText = context.resolve(pageNumberText)
				
				let pageNumberTextSize = resolvedPageNumberText.measure(in: pageToRenderInfo.visualRect.size)
				
				context.draw(
					resolvedPageNumberText,
					in: CGRect(
						x: pageNumberCenter.x - pageNumberTextSize.width / 2,
						y:pageNumberCenter.y - pageNumberTextSize.height / 2,
						width: pageToRenderInfo.visualRect.size.width,
						height: pageToRenderInfo.visualRect.size.height
					)
				)
			}
		}
		.gesture(
			DragGesture()
				.onChanged({ state in
					if dragGestureState == nil {
						dynamics.startDrag(gestureState: state)
					}
					
					dragGestureState = state
				})
				.onEnded({ state in
					dragGestureState = state
					dynamics.endDrag(gestureState: state)
					dragGestureState = nil
				})
		)
		.onReceive(updateTimer) { _ in
			dynamics.update(gestureState: dragGestureState)
		}
    }
}

#Preview {
	PagedView(dynamics: SimplestPagingDynamics())
}
