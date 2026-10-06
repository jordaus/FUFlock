//
//  CameraRepository.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/22/26.
//

import Foundation

enum CameraRepository {
    enum LoadError: Error {
        case fileNotFound
        case invalidCollection
        case invalidCamera(String)
    }
    
    static func loadCameras() throws -> (cameras: [FlockCam], snapshotDate: Date?) {
        guard let url = Bundle.main.url(
            forResource: "htx_alpr",
            withExtension: "geojson"
        ) else {
            throw LoadError.fileNotFound
        }
        
        let data = try Data(contentsOf: url)
        let collection = try JSONDecoder().decode(
            CameraGeoJSON.self,
            from: data
        )
        
        guard collection.type == "FeatureCollection" else {
            throw LoadError.invalidCollection
        }
        
        let cameras = try collection.features.compactMap { feature -> FlockCam? in
            let properties = feature.properties
            
            guard properties.surveillanceType == "ALPR" else {
                return nil
            }
            
            let coordinates = feature.geometry.coordinates
            guard feature.type == "Feature",
                  feature.geometry.type == "Point",
                  coordinates.count >= 2,
                  (-180.0...180.0).contains(coordinates[0]),
                  (-90.0...90.0).contains(coordinates[1]) else {
                throw LoadError.invalidCamera(feature.id)
            }
            
            return FlockCam(
                id: feature.id,
                latitude: coordinates[1],
                longitude: coordinates[0],
                manufacturer: properties.manufacturer,
                operatorName: properties.operatorName,
                direction: properties.direction ?? properties.cameraDirection,
                mount: properties.mount,
                name: properties.name
            )
        }
        
        let snapshotDate = collection.timestamp.flatMap {
            ISO8601DateFormatter().date(from: $0)
        }
        
        return (cameras: cameras, snapshotDate: snapshotDate)
    }
}
