//
//  DottedCircle.swift
//  Activity Indicator
//
//  Created by Antoine on 02/08/2020.
//

import SwiftUI

struct DottedCircle: View {
    
    @State var indexOfHighlight: Int = 7
    
    var scaleRatios: [CGFloat] = [1.2,1,0.8,0.6,0.6,0.6,0.6,0.6].reversed()
    
    var body: some View {
        GeometryReader { geo in
            ForEach(0..<8) { i in
                Circle().fill()
                    .frame(width: widthForCircleIn(geo.size),
                            height: widthForCircleIn(geo.size))
                    .transformEffect(CGAffineTransform(
                                        scaleX: scaleForIndex(i),
                                        y: scaleForIndex(i)))
                    .offset(y: widthForCircleIn(geo.size) * 1.5)
                    .rotationEffect(angleForIndex(i))
            }
            .offset(x: geo.size.width / 2 - widthForCircleIn(geo.size) / 2,
                    y: geo.size.height / 2 - widthForCircleIn(geo.size) / 2)
        }.onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.5/8/2, repeats: true) { (_) in
                withAnimation(.linear(duration: 1.5/8/2)) {
                    // Forcing the rotation to look like clockwise (with reversed array)
                    indexOfHighlight += indexOfHighlight == 0 ? 7 : -1
                }
            }
        }
    }
    
    func widthForCircleIn(_ size: CGSize) -> CGFloat {
        min(size.width, size.height) / 5
    }
    
    func angleForIndex(_ index: Int) -> Angle {
        Angle(degrees: (360/8)*Double(index))
    }
    
    func scaleForIndex(_ index: Int) -> CGFloat {
        scaleRatios[(index + indexOfHighlight) % 8]
    }
}


