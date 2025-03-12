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
        VStack {
            Text("\(Int(percent))%")
                .font(.system(size: 72, weight: .bold, design: .default))
            
            ProgressBar(width: 300, height: 30, percent: percent, baseColor:Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.09622130102)), barColor:Color(#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)))
                .animation(.bouncy)
            
            ZStack {
                Rectangle()
                    .frame(width: 250, height: 30)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
                
                HStack {
                    Button (action: { percent = percent - 5 },
                            label: { Text("Decrease") })
                    
                    Button(action: { percent = CGFloat.random(in: 0...100)},
                           label: { Text("Randomize") })
                    
                    Button (action: { percent = percent + 5 },
                            label: { Text("Increase") })
                }
            }
        }
        .padding(.top, -350)
    }
}

#Preview {
    ContentView()
}
