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
                    } else if(menuState == 3){
                        ZStack {
                            
                            Rectangle()
                                .frame(width: 375, height: 350)
                                .foregroundColor(Color(#colorLiteral(red: 0.8431431651, green: 0.6916723847, blue: 0.4057167172, alpha: 1)))
                            
                            ScrollView {
                                VStack(alignment: .leading) {
                                    Text("We all love the sun. It’s warm, gives you a little boost of serotonin when you step outside, and brightens any kind of vibe. All good things, right?")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("NO. There is a sneaky villain hiding behind those sun rays: UV RADIATION")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("What is UV radiation anyway?")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(#colorLiteral(red: 0.5028434396, green: 0.598954618, blue: 0.3286795616, alpha: 1)))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                        .padding(.bottom, -30)
                                    Text("UV stands for ultraviolet radiation. It comes from the sun, is invisible, and causes all kinds of chaos without you even noticing")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("There are two main types of UV radiation...")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text(" - UVA: This one damages the surface of your skin. It speeds up aging and gives you early wrinkles and fine lines on your skin :( \n - UVB: This one targets the depths of your skin. It causes sunburn, like the painful, red, can’t-sleep-on-your-back kind of sunburn")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .trailing], 20)
                                        .padding(.leading, 50)
                                    Text("Basically, both types can damage your skin cells—and thats when things get kinda dangerous.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Let’s Talk About Skin Cancer")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(#colorLiteral(red: 0.5028434396, green: 0.598954618, blue: 0.3286795616, alpha: 1)))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                        .padding(.bottom, -30)
                                    Text("We are not here to scare you. But also, a little bit of fear is healthy.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Here is the reality: UV damage builds up over time. One bad sunburn can double your risk of skin cancer later in life. And it doesn’t matter what skin tone you have (do NOT skip out on sunscreen even if you have dark skin). Skin cancer can affect everyone.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("The most serious type of skin cancer is melanoma, and it can spread to other parts of your body if it is not caught early on. However, most of this is totally preventable with basic sun prevention!")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Sunscreen!! (Cancer Defense System)")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(#colorLiteral(red: 0.5028434396, green: 0.598954618, blue: 0.3286795616, alpha: 1)))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                        .padding(.bottom, -30)
                                    Text("The easiest way to protect yourself? SUNSCREEN EVERY SINGLE DAY ")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Be sure to apply at least SPF 30 even on cloudy days and especially if you are outside. Don’t forget places like your ears, neck, and back.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("It’s not just about avoiding sunburns, it’s about protecting your cells from DNA damage that can lead to skin cancer later.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Bottom Line?")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color(#colorLiteral(red: 0.5028434396, green: 0.598954618, blue: 0.3286795616, alpha: 1)))
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                        .padding(.bottom, -30)
                                    Text("The sun should not be your enemy, but it definitely needs to be handled with caution. UV rays may be invisible, but the damages they do can be deadly.")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text("Protect yourself...")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .leading, .trailing], 20)
                                    Text(" - wear sunscreen! \n - cover up (hats, long sleeves, sunglasses) \n - stay in the shade")
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding([.top, .trailing], 20)
                                        .padding(.leading, 50)
                                }
                            }
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
