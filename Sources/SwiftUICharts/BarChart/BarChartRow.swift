//
//  ChartRow.swift
//  ChartView
//
//  Created by András Samu on 2019. 06. 12..
//  Copyright © 2019. András Samu. All rights reserved.
//

import SwiftUI

public struct BarChartRow : View {
    var data: [Double]
    var accentColor: Color
    var gradient: GradientColor?
    
    var maxValue: Double {
        guard let max = data.max() else {
            return 1
        }
        return max != 0 ? max : 1
    }
    @Binding var touchLocation: CGFloat
    public var body: some View {
        GeometryReader { geometry in
            let availableWidth = geometry.frame(in: .local).width - 22
            let barWidth = availableWidth / CGFloat(Double(self.data.count) * 1.5)
            let totalBarWidth = barWidth * CGFloat(self.data.count)
            let remainingSpace = availableWidth - totalBarWidth
            let spacing = remainingSpace / CGFloat(self.data.count + 1)
            
            HStack(alignment: .bottom, spacing: 0) {
                Spacer()
                    .frame(width: spacing)
                
                ForEach(0..<self.data.count, id: \.self) { i in
                    BarChartCell(value: self.normalizedValue(index: i),
                                 index: i,
                                 width: Float(barWidth),
                                 numberOfDataPoints: self.data.count,
                                 accentColor: self.accentColor,
                                 gradient: self.gradient,
                                 touchLocation: self.$touchLocation)
                        .scaleEffect(self.touchLocation > CGFloat(i)/CGFloat(self.data.count) && self.touchLocation < CGFloat(i+1)/CGFloat(self.data.count) ? CGSize(width: 1.4, height: 1.1) : CGSize(width: 1, height: 1), anchor: .bottom)
                        .animation(.spring())
                    
                    if i < self.data.count - 1 {
                        Spacer()
                            .frame(width: spacing)
                    }
                }
                
                Spacer()
                    .frame(width: spacing)
            }
            .padding([.top, .leading, .trailing], 10)
        }
    }
    
    func normalizedValue(index: Int) -> Double {
        return Double(self.data[index])/Double(self.maxValue)
    }
}

#if DEBUG
struct ChartRow_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            BarChartRow(data: [0], accentColor: Colors.OrangeStart, touchLocation: .constant(-1))
            BarChartRow(data: [8,23,54,32,12,37,7], accentColor: Colors.OrangeStart, touchLocation: .constant(-1))
        }
    }
}
#endif
