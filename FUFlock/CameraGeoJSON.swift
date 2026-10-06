//
//  CameraGeoJSON.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/22/26.
//

import Foundation

struct CameraGeoJSON: Decodable {
    let type: String
    let timestamp: String?
    let features: [CameraFeature]
}

struct CameraFeature: Decodable {
    let type: String
    let id: String
    let geometry: CameraGeometry
    let properties: CameraProperties
}

struct CameraGeometry: Decodable {
    let type: String
    let coordinates: [Double]
}

struct CameraProperties: Decodable {
    let name: String?
    let manufacturer: String?
    let operatorName: String?
    let surveillanceType: String?
    let direction: String?
    let cameraDirection: String?
    let mount: String?

    enum CodingKeys: String, CodingKey {
        case name
        case manufacturer
        case direction
        case operatorName = "operator"
        case surveillanceType = "surveillance:type"
        case cameraDirection = "camera:direction"
        case mount = "camera:mount"
    }
}
