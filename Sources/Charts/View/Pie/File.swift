//
//  DonutChart.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
public struct DonutChart<T>: View where T: CircleChartProtocol {
    
    @ObservedObject public var vm: T
    @State private var selectedPieChartElement: Int? = nil
    public let action: ((ChartDataProvidable) -> Void)?
    
    
    public init(vm: T, action: ((ChartDataProvidable) -> Void)?) {
        self.vm = vm
        self.action = action
    }
    
    public var body: some View {
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
                        let center = getLabelCoordinate(in: geometry.size, for: lastDegree + (currentEndDegree / 2), with: vm.labelSpacing)
                        PieLabel(currentData: currentData, spaceOffSet: vm.dataSpacing)
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
    
    func getLabelCoordinate(in geoSize: CGSize, for degree: Double, with offSet: CGFloat) -> CGPoint {
        let center = CGPoint(x: geoSize.width / 2, y: geoSize.height / 2)
        let radius = ((geoSize.width / 3) + 75) + offSet
        let radian = CGFloat(degree) * (CGFloat.pi / 180)
        let yCoordinate = radius * sin(radian)
        let xCoordinate = radius * cos(radian)
        return CGPoint(x: center.x + xCoordinate, y: center.y + yCoordinate)
    }
}

