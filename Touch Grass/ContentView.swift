//
//  ContentView.swift
//  Touch Grass
//
//  Created by Adrien Chew on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @State var percent: CGFloat = 0
    
    var body: some View {
        // Background Color Depth Stack
        ZStack {
            //#F0C573
            Color(#colorLiteral(red: 0.94106704, green: 0.7699710727, blue: 0.4476546049, alpha: 1))
                .ignoresSafeArea()
            
            // Main Menu Elements Vertical Stack
            VStack(alignment: .center, spacing: 20) {
                // Title
                Image("Title")
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size * 0.9
                    }
                
                ZStack {
                    ProgressBar(width: 300, height: 30, percent: percent, baseColor:Color(#colorLiteral(red: 0.7319011092, green: 0.8224027753, blue: 0.5652881265, alpha: 1)), barColor:Color(#colorLiteral(red: 0.5028434396, green: 0.598954618, blue: 0.3286795616, alpha: 1)))
                        .animation(.bouncy)
                    
                    Text("\(Int(percent))%")
                        .font(.system(size: 24, weight: .bold, design: .default))
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 250, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                    
                    HStack {
                        Button (action: { percent = percent - 5 },
                                label: { Text("Decrease") })
                        
                        Button (action: { percent = CGFloat.random(in: 0...100)},
                               label: { Text("Randomize") })
                        
                        Button (action: { percent = percent + 5 },
                                label: { Text("Increase") })
                    }
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 375, height: 300)
                        .foregroundColor(Color(#colorLiteral(red: 0.94106704, green: 0.7699710727, blue: 0.4476546049, alpha: 1)))
                    
                    Text("TEXT")
                        .font(.system(size: 72, weight: .bold, design: .default))
                }
                    
                // Menu Template
                Image("MenuTemplate")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                    .containerRelativeFrame(.horizontal) { size, axis in
                        size
                    }
                    .opacity(0.3)
                
                // Menu
            }
            .padding(.top, 50)
        }
    }
}

#Preview {
    ContentView()
}
