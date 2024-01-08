//
//  PagingIndicator.swift
//  Activity Indicators
//
//  Created by 성준모 on 1/7/24.
//

import SwiftUI

struct PagingIndicator: View {
    // MARK: - CUSTOM PROPERTIES
    var activeTint: Color = .primary
    var inActiveTint: Color = .primary.opacity(0.15)
    var opacityEffect: Bool = false
    var clipEdges: Bool = false
    
    // MARK: - BODY
    var body: some View {
        GeometryReader {
            
            let width = $0.size.width
            
            if let scrollViewWidth = $0.bounds(of: .scrollView(axis: .horizontal))?.width, scrollViewWidth > 0 {
                
                let minX = $0.frame(in: .scrollView(axis: .horizontal)).minX
                let totalPages = Int(width / scrollViewWidth)
                
                let freeProgress = -minX / scrollViewWidth
                let clippedProgress = min(max(freeProgress, 0.0), CGFloat(totalPages - 1))
                let progress = clipEdges ? clippedProgress : freeProgress
                
                // Indexes
                let activeIndex = Int(progress)
                let nextIndex = Int(progress.rounded(.awayFromZero))
                let indicatorProgress = progress - CGFloat(activeIndex)
                
                // Indicator Width's (Current & Upcoming)
                let currentPageWidth = 18 - (indicatorProgress * 18)
                let nextPageWidth = indicatorProgress * 18
                
                HStack(spacing: 10) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Capsule()
                            .fill(inActiveTint)
                            .frame(width: 8 + (activeIndex == index ? currentPageWidth : nextIndex == index ? nextPageWidth : 0), height: 8)
                            .overlay {
                                ZStack {
                                    Capsule()
                                        .fill(inActiveTint)
                                    
                                    Capsule()
                                        .fill(activeTint)
                                        .opacity(opacityEffect ? activeIndex == index ? 1 - indicatorProgress : nextIndex == index ? indicatorProgress : 0 : 1)
                                }
                            }
                    } //: LOOP
                } //: HSTACK
                .frame(width: scrollViewWidth)
                .overlay(content: {
                    Text("\(activeIndex) \(nextIndex)")
                        .offset(y: -100)
                })
                .offset(x: -minX)
            }
        }
        .frame(height: 30)
    }
}

#Preview {
    ContentView()
}
