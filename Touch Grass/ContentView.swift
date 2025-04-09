//
//  ContentView.swift
//  Touch Grass
//
//  Created by Adrien Chew on 3/3/25.
//

import SwiftUI
import CoreLocationUI
import MapKit

// Bluetooth stuff


struct ContentView: View {
    @StateObject var bleManager = BLEManager()
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30, longitude: -97), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
    @State var percent: CGFloat = 0
    @State var text: String = "(Placeholder)"
    @State var menuState: CGFloat = 0
    
    func homePressed() {
        text = "Home"
        menuState = 1
    }
    
    func infoPressed() {
        text = "Info"
        menuState = 2
    }
    
    func dangersPressed() {
        text = "Dangers"
        menuState = 3
    }
    
    func UVPressed() {
        text = "UV Index"
        menuState = 4
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
                    
                    if(menuState == 1) {
                        VStack(spacing: 10) {
                            Text("Bluetooth Devices")
                                .font(.system(size: 24, weight: .bold, design: .default))
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            List(bleManager.peripherals) { peripheral in
                                HStack {
                                    Text(peripheral.name)
                                    Spacer()
                                    Text(String(peripheral.rssi))
                                    Button(action: {
                                        bleManager.connect(to: peripheral)
                                    }) {
                                        if bleManager.connectedPeripheralUUID == peripheral.id {
                                            Text("Connected")
                                                .foregroundColor(.green)
                                        } else {
                                            Text("Connect")
                                        }
                                    }
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: 200, alignment: .center)
                            
//                            Spacer()
                            
                            if bleManager.isSwitchedOn {
                                Text("Bluetooth ON")
                                    .foregroundColor(.green)
                            } else {
                                Text("Bluetooth OFF")
                                    .foregroundColor(.red)
                            }
                            
                            Button(action: {
                                bleManager.startScanning()
                            }) {
                                Text("Start Scanning")
                            }.buttonStyle(BorderedProminentButtonStyle())
                            
                            Button(action: {
                                bleManager.stopScanning()
                            }) {
                                Text("Stop Scanning")
                            }.buttonStyle(BorderedProminentButtonStyle())
                        }
                        .onAppear {
                            if bleManager.isSwitchedOn {
                                bleManager.startScanning()
                            }
                        }
                    } else if(menuState == 2){
                        ZStack(alignment: .bottom) {
                            Map(coordinateRegion: $region, showsUserLocation: true)
                                .tint(.pink)
                            
                            LocationButton(.currentLocation) {
                                print("Get Location")
                            }
                            .padding(.bottom, 50)
                        }
                    }
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
//                        .frame(width: 400.0, height: 200.0)
                        .offset(x: -0, y: -10)
                        .scaledToFill()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 430, height: 300)
                        .ignoresSafeArea(.all)
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size
                        }
                    
                    Button (action: { homePressed() }) {
                        if (menuState == 1) {
                            Image("BloomButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 80)
                        } else {
                            Image("BudButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 80)
                        }
                    }
                    .offset(x: -120, y: -90)
                    
                    Button (action: { infoPressed() }) {
                        if (menuState == 2) {
                            Image("BloomButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 80)
                        } else {
                            Image("BudButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 80)
                        }
                    }
                    .offset(x: -45, y: -90)
                    
                    Button (action: { dangersPressed() }) {
                        if (menuState == 3) {
                            Image("BloomButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 80)
                        } else {
                            Image("BudButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 80)
                        }
                    }
                    .offset(x: 50, y: -115)
                    
                    Button (action: { UVPressed() }) {
                        if (menuState == 4) {
                            Image("BloomButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 80)
                        } else {
                            Image("BudButton")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 50, height: 80)
                        }
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
