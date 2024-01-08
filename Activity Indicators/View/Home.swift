//
//  Home.swift
//  Activity Indicators
//
//  Created by 성준모 on 1/7/24.
//

import SwiftUI

struct Home: View {
    // MARK: - PROPERTY
    @State var colors: [Color] = [.red, .indigo, .cyan, .purple]
    @State var opacityEffect: Bool = false
    @State var clipEdges: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            // MARK: - Paging view
            ScrollView(.horizontal) {
                LazyHStack(spacing: 0) {
                    ForEach(colors, id: \.self) { color in
                        RoundedRectangle(cornerRadius: 25.0)
                            .fill(color.gradient)
                            .padding(.horizontal, 5)
                            /*
                             containerRelativeFrame
                             해당 뷰의 컨테이너 넓이가 변경되어도 뷰의 크기가 자동으로 업데이트
                             
                             frame을 통해 height는 고정이지만 horizontal을 넣어 사용하면 기기 혹은 뷰의 사이즈가 늘어나더라도 그에 맞춰 해당 뷰의 넓이가 늘어납니다.
                             */
                            .containerRelativeFrame(.horizontal)
                    } //: LOOP
                } //: HSTACK
                .scrollTargetLayout()
                .overlay(alignment: .bottom) {
                    PagingIndicator(activeTint: .white,
                                    inActiveTint: .black.opacity(0.25),
                                    opacityEffect: opacityEffect,
                                    clipEdges: clipEdges
                    )
                }
            } //: SCROLLVIEW
            /*
             .scrollTargetBehavior
             내부적으로 스크롤 대상을 컨테이너 기반 도형에 맞춰 정렬하는 스크롤 동작을 가짐
             
             .padding "페이징 방식"
             
             .viewAligned 뷰 기반 형상에 정렬하는 스크롤 동작을 가짐
             스크롤 뷰가 항상 스크롤 대상을 뷰의 기하학적 구조에 맞춰
             정렬된 직사각형에 정렬해야 할 때 이 동작을 사용할 수 있음
             */
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .frame(height: 220)
            .safeAreaPadding(.vertical, 15)
            .safeAreaPadding(.horizontal, 25)
            
            List {
                Section("Options") {
                    Toggle("Opacity Effect", isOn: $opacityEffect)
                    Toggle("Clip Edges", isOn: $clipEdges)
                    
                    Button("Add Iten") {
                        colors.append(.yellow)
                    }
                }
            } //: LIST
            .clipShape(.rect(cornerRadius: 20))
            .padding(15)
        } //: NAVIGATION STACK
        .navigationTitle("Custon Indicator")
    }
}

#Preview {
    ContentView()
}
