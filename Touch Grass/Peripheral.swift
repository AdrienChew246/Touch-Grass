//
//  Peripheral.swift
//  Touch Grass
//
//  Created by Adrien Chew on 3/25/25.
//

import Foundation

struct Peripheral: Identifiable {
    let id: UUID
    let name: String
    let rssi: Int        // signal strength
}
