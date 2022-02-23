//
//  LineChart.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct LineChart<T>: View where T: LineChartViewModel  {
    
    @ObservedObject public var vm: T
    
    public init(vm: T) {
        self.vm = vm
    }
    
    public var body: some View {
        
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let data = vm.data.map { CGFloat($0.value) }
            
            let points: [CGPoint] = {
                guard data.count > 1 else { return [] }
                var pointArray = [CGPoint]()
                let normalizedData = data.normalized
                for index in normalizedData.indices {
                    let point = normalizedData[index]
                    let x = width * CGFloat(index) / CGFloat(data.count - 1)
                    let y = (1 - point) * height
                    pointArray.append(CGPoint(x: x, y: y))
                }
                return pointArray
            }()
            
            ZStack {
                ClosedLineGraph(dataPoints: points)
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.09), Color.blue.opacity(0.3)]),
                                       startPoint: .bottom,
                                       endPoint: .top)
                    )
                
                if  let target = vm.target, let min = data.min(), let max = data.max() {
                    BudgetLineGraphBackground(data: target, min: min, max: max)
                        .stroke(Color.gray.opacity(0.5), style: StrokeStyle(lineWidth: 1, dash: [5]))
                }
                
                LineGraph(dataPoints: points)
                    .trim(to: vm.animateChart ? 1 : 0)
                    .stroke(Color.blue)
                    .frame(width: width, height: height)
                    .overlay(
                        VStack(spacing: 0) {
                            Text(vm.currentPlot)
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(Color.blue, in: Capsule())
                                .offset(x: vm.translation < 10 ? 30 : 0)
                                .offset(x: vm.translation > (width - 90) ? -30 : 0)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 1, height: 45)
                                .padding(.top)
                            
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 22, height: 22)
                            
                            Rectangle()
                                .fill(Color.blue)
                                .frame(width: 1, height: 45)
                        }
                            .frame(width: 80, height: 170)
                            .offset(y: 65)
                            .opacity(vm.showPlot ? 1 : 0)
                            .offset(vm.offset), alignment: .bottomLeading
                    )
                    .contentShape(Rectangle())
                    .gesture(DragGesture().onChanged({ value in
                        withAnimation {
                            vm.showPlot = true
                            
                            let translation = value.location.x - 40
                            withAnimation {
                                vm.translation = translation
                            }
                            let dataCount = vm.data.count - 1
                            let minV = min(Int(((translation / (width - 90)) * CGFloat(dataCount)).rounded() + 1), dataCount)
                            let index = max(minV, 0)
                            vm.currentPlot = "$ \(data[index])"
                            
                            vm.offset = CGSize(width: points[index].x - 40, height: points[index].y - height)
                        }
                    }).onEnded({ value in
                        withAnimation {
                            vm.showPlot = false
                        }
                    }))
                    .onAppear {
                        withAnimation(.easeOut(duration: 2)) {
                            vm.animateChart = true
                        }
                        print(vm.data.count)
                    }
            }
        }
        
    }
}

extension Array where Element == CGFloat {
    /// Returns elements of the sequence, normalized
    var normalized: [CGFloat] {
        if let min = self.min(), let max = self.max() {
            return self.map { ($0 - min) / (max - min)}
        }
        return []
    }
    
}
