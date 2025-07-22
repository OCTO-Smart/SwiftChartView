//
//  LabelView.swift
//  BarChart
//
//  Created by Samu András on 2020. 01. 08..
//  Copyright © 2020. Samu András. All rights reserved.
//

import SwiftUI
import Combine


struct LabelView: View {
    @Binding var arrowOffset: CGFloat
    @Binding var title: String
    @Binding var measuredWidth: CGFloat

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text(self.title)
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        GeometryReader { geo in
                            if #available(iOS 14.0, *) {
                                Color.clear
                                    .onAppear {
                                        self.measuredWidth = geo.size.width
                                    }
                                    .onChange(of: geo.size.width) { newValue in
                                        self.measuredWidth = newValue
                                    }
                            } else {
                                Color.clear
                                     .onAppear {
                                         self.measuredWidth = geo.size.width
                                     }
                                     .onReceive(Just(geo.size.width)) { newValue in
                                         self.measuredWidth = newValue
                                     }
                            }
                        }
                    )
            }
            .fixedSize()
        }
    }

    func getArrowOffset(offset: CGFloat) -> CGFloat {
        return max(-36, min(36, offset))
    }
}

struct ArrowUp: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height))
        path.addLine(to: CGPoint(x: rect.width/2, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        path.closeSubpath()
        return path
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(arrowOffset: .constant(0), title: .constant("Tesla model 3"),
                  measuredWidth: .constant(100))
    }
}
