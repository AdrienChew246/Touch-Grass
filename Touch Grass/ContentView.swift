//
//  ContentView.swift
//  Touch Grass
//
//  Created by Adrien Chew on 3/3/25.
//

import SwiftUI

struct ContentView: View {
    @State var percent: CGFloat = 0
    @State var text: String = "(Placeholder)"
    
    func homePressed() {
        text = "Home"
    }
    
    func infoPressed() {
        text = "Info"
    }
    
    func dangersPressed() {
        text = "Dangers"
    }
    
    func UVPressed() {
        text = "UV Index"
    }
    
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
                        .frame(width: 150, height: 30)
                        .foregroundColor(Color(#colorLiteral(red: 0.7319011092, green: 0.8224027753, blue: 0.5652881265, alpha: 1)))
                    
                    Button (action: { percent = percent + 5 },
                            label: { Text("TOUCH GRASS!!!") })
                    
//                    HStack {
//                        Button (action: { percent = percent - 5 },
//                                label: { Text("Decrease") })
//                        
//                        Button (action: { percent = CGFloat.random(in: 0...100)},
//                               label: { Text("Randomize") })
//                        
//                        Button (action: { percent = percent + 5 },
//                                label: { Text("Increase") })
//                    }
                }
                
                ZStack {
                    Rectangle()
                        .frame(width: 375, height: 350)
                        .foregroundColor(Color(#colorLiteral(red: 0.94106704, green: 0.7699710727, blue: 0.4476546049, alpha: 1)))
                    
                    Text(text)
                        .font(.system(size: 42, weight: .bold, design: .default))
                }
                
                ZStack {
                    // Menu Template
                    Image("MenuTemplate")
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size
                        }
                        .opacity(0.0)
                    
                    // Menu
                    Image("Menu")
                        .resizable()
                        .frame(width: 400.0, height: 200.0)
                        .scaledToFill()
                        .ignoresSafeArea(.all)
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size
                        }
                    
                    Button (action: { homePressed() }) {
                        Image("HomeButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 90, height: 80)
                    }
                    .offset(x: -102, y: -125)
                    
                    Button (action: { infoPressed() }) {
                        Image("InfoButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 65)
                    }
                    .offset(x: -35, y: -100)
                    
                    Button (action: { dangersPressed() }) {
                        Image("DangersButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 90)
                    }
                    .offset(x: 50, y: -135)
                    
                    Button (action: { UVPressed() }) {
                        Image("UVButton")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 70, height: 80)
                    }
                    .offset(x: 125, y: -105)
                }
            }
            .padding(.top, 100)
        }
    }
}

#Preview {
    ContentView()
}
