//
//  FlockCam.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/21/26.
//

import Foundation

struct FlockCam : Identifiable, Hashable {
    let id: String
    let latitude: Double
    let longitude: Double
    let manufacturer: String?
    let operatorName: String?
    let direction: String?
    let mount : String?
    let name: String?
}
