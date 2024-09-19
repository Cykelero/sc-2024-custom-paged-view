//
//  ContentView.swift
//  CustomPagedView
//
//  Created by Nathan Manceaux-Panot on 2024-09-13.
//

import SwiftUI

struct ContentView: View {
	let availableDynamics: [any PagingDynamics.Type] = [SimplestPagingDynamics.self, WithSnappingPagingDynamics.self]
	
	@State var selectedDynamicsIndex = 0
	var selectedDynamics: any PagingDynamics.Type {
		availableDynamics[selectedDynamicsIndex]
	}
	
    var body: some View {
		NavigationStack {
			GeometryReader { geometry in
				PagedView(pageWidth: geometry.size.width, dynamics: selectedDynamics.init())
					.id(selectedDynamicsIndex)
			}
			.toolbar {
				ToolbarItem(placement: .topBarLeading) {
					Picker("Paging dynamic", selection: $selectedDynamicsIndex) {
						ForEach(availableDynamics.indices, id: \.self) { availableDynamicIndex in
							let availableDynamic = availableDynamics[availableDynamicIndex]
							let availableDynamicNumber: Int = availableDynamicIndex + 1
							
							Text("\(availableDynamicNumber.romanNumeral ?? String(availableDynamicNumber)). \(availableDynamic.name)")
						}
					}
				}
			}
		}
	}
}

#Preview {
    ContentView()
}
