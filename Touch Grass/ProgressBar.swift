//
//  ProgressBar.swift
//  Touch Grass
//
//  Created by Adrien Chew on 3/12/25.
//

import SwiftUI

struct ProgressBar: View {
    var width: CGFloat = 200
    var height: CGFloat = 20
    var percent: CGFloat = 50
    var baseColor = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
    var barColor = Color(#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1))
    
    
    var body: some View {
        let multiplier = width / 100
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: width, height: height)
                .foregroundColor(baseColor)
            
            RoundedRectangle(cornerRadius: height, style: .continuous)
                .frame(width: percent * multiplier, height: height)
                .foregroundColor(barColor)
            
            
//            Image("ProgressBarLeft")
//                .resizable()
//                .scaledToFit()
//                .frame(width: percent * multiplier, height: height)
//            
//            Image("ProgressBarRight")
//                .resizable()
//                .scaledToFit()
//                .frame(width: percent * multiplier, height: height)
//          
//            Image("ProgressBar")
//                .resizable()
//                .frame(width: percent * multiplier, height: height)
        }
    }
}

#Preview {
    ProgressBar()
}
