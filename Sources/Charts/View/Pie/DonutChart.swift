//
//  DonutChart.swift
//  
//
//  Created by Jonathan Dowdell on 2/23/22.
//

import SwiftUI

@available(iOS 13.0, *)
public struct DonutChart<T>: View where T: ChartViewModel {
    
    @ObservedObject var vm: T
    @State var selectedPieChartElement: Int? = nil
    let action: ((ChartDataProvidable) -> Void)?
    
    
    var body: some View {
        ZStack {
            let chartData = vm.chartData
            ForEach(0 ..< chartData.count) { index in
                let currentData = chartData[index]
                let currentEndDegree = currentData.value * 360
                let lastDegree = chartData.prefix(index)
                    .map { $0.value }.reduce(0, +) * 360
                
                ZStack(alignment: .center) {
                    
                    PieceOfPie(startDegree: lastDegree, endDegree: lastDegree + currentEndDegree)
                        .fill(currentData.color)
                        .scaleEffect(index == selectedPieChartElement ? 1.2 : 1.0)
                    
                    GeometryReader { geometry in
                        let center = getLabelCoordinate(in: geometry.size, for: lastDegree + (currentEndDegree / 2))
                        PieLabel(currentData: currentData)
                            .position(center)
                    }
                    .scaleEffect(index == selectedPieChartElement ? 1.2 : 1.0)
                }
                .onTapGesture {
                    withAnimation() {
                        if index == selectedPieChartElement {
                            selectedPieChartElement = nil
                        } else if currentData.color != .white {
                            selectedPieChartElement = index
                            if let action = action, currentData.color != .white {
                                action(currentData)
                            }
                        }
                    }
                }
            }
            PieWhiteCenter() {
                withAnimation {
                    selectedPieChartElement = nil
                }
            }
        }
    }
    
    func getLabelCoordinate(in geoSize: CGSize, for degree: Double) -> CGPoint {
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        let radius = (geoSize.width / 3) + 75
        let radian = CGFloat(degree) * (CGFloat.pi / 180)
        let yCoordinate = radius * sin(radian)
        let xCoordinate = radius * cos(radian)
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
    }
}

@available(iOS 13.0, *)
struct PieWhiteCenter: View {
    let action: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            Circle()
                .fill(Color.white)
                .position(CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                .frame(width: geometry.size.width * 0.88, height: geometry.size.height * 0.88, alignment: .center)
        }
        .onTapGesture {
            if let action = action {
                action()
            }
        }
    }
}
