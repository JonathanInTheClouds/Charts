//
//  File.swift
//  
//
//  Created by Mettaworldj on 2/23/22.
//

import SwiftUI

@available(iOS 15.0, *)
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
