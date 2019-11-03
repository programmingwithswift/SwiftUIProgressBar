//
//  ContentView.swift
//  ProgressBar
//
//  Copyright © 2019 ProgrammingWithSwift. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    private let value: Double
    private let maxValue: Double
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    
    init(value: Double,
         maxValue: Double,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = Color(UIColor(red: 245/255,
                                                green: 245/255,
                                                blue: 245/255,
                                                alpha: 1.0)),
         foregroundColor: Color = Color.black) {
        self.value = value
        self.maxValue = maxValue
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
    }
    
    var body: some View {
        // 1
        ZStack {
            // 2
            GeometryReader { geometryReader in
                // 3
                if self.backgroundEnabled {
                    Capsule()
                        .foregroundColor(self.backgroundColor) // 4
                }
                
                Capsule()
                    .frame(width: self.progress(value: self.value,
                                                maxValue: self.maxValue,
                                                width: geometryReader.size.width)) // 5
                    .foregroundColor(self.foregroundColor) // 6
                    .animation(.easeIn) // 7
            }
        }
    }
    
    private func progress(value: Double,
                          maxValue: Double,
                          width: CGFloat) -> CGFloat {
        let percentage = value / maxValue
        return width *  CGFloat(percentage)
    }
}

struct ProgressCircle: View {
    enum Stroke {
        case line
        case dotted
        
        func strokeStyle(lineWidth: CGFloat) -> StrokeStyle {
            switch self {
            case .line:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round)
            case .dotted:
                return StrokeStyle(lineWidth: lineWidth,
                                   lineCap: .round,
                                   dash: [12])
            }
        }
    }
    
    private let value: Double
    private let maxValue: Double
    private let style: Stroke
    private let backgroundEnabled: Bool
    private let backgroundColor: Color
    private let foregroundColor: Color
    private let lineWidth: CGFloat
    
    init(value: Double,
         maxValue: Double,
         style: Stroke = .line,
         backgroundEnabled: Bool = true,
         backgroundColor: Color = Color(UIColor(red: 245/255,
                                                green: 245/255,
                                                blue: 245/255,
                                                alpha: 1.0)),
         foregroundColor: Color = Color.black,
         lineWidth: CGFloat = 10) {
        self.value = value
        self.maxValue = maxValue
        self.style = style
        self.backgroundEnabled = backgroundEnabled
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.lineWidth = lineWidth
    }
    
    var body: some View {
        ZStack {
            if self.backgroundEnabled {
                Circle()
                    .stroke(lineWidth: self.lineWidth)
                    .foregroundColor(self.backgroundColor)
            }
            
            Circle()
                .trim(from: 0, to: CGFloat(self.value / self.maxValue))
                .stroke(style: self.style.strokeStyle(lineWidth: self.lineWidth))
                .foregroundColor(self.foregroundColor)
                .rotationEffect(Angle(degrees: -90))
                .animation(.easeIn)
        }
    }
}

//
//    private func progress(value: Double,
//                          maxValue: Double) -> CGFloat {
//        return CGFloat(value / maxValue)
//    }
//}

struct ContentView: View {
    @State private var sliderValue: Double = 0
    private let maxValue: Double = 10
    
    var body: some View {
        VStack {
            ProgressBar(value: $sliderValue.wrappedValue,
                        maxValue: self.maxValue,
                        foregroundColor: .green)
                .frame(height: 10)
                .padding(30)
            
            ProgressCircle(value: $sliderValue.wrappedValue,
                           maxValue: self.maxValue,
                           style: .dotted,
                           foregroundColor: .red,
                           lineWidth: 10)
            .frame(height: 100)
            
            Spacer()
            
            Slider(value: $sliderValue,
                   in: 0...maxValue)
            .padding(30)
        }
    }
}

//struct ContentView: View {
//    @State private var sliderValue: Double = 0
//    private let maxValue: Double = 10
//
//    var body: some View {
//        VStack {
//            ProgressBar(value: $sliderValue.wrappedValue,
//                        maxValue: maxValue,
//                        foregroundColor: .green)
//                .frame(height: 10)
//                .padding(30)
//            ProgressCircle(value: $sliderValue.wrappedValue,
//                           maxValue: maxValue,
//                           style: .dotted,
//                           foregroundColor: .red)
//                .frame(height: 100)
//
//            Spacer()
//
//            Slider(value: $sliderValue,
//                in: 0...maxValue)
//            .padding(30)
//        }
//    }
//}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
