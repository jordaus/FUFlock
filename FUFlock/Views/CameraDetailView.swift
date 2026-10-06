//  CameraDetailView.swift
//  FUFlock
//
//  Created by Jordan Austin on 10/3/26.
//

import SwiftUI

struct CameraDetailView: View {
    
    var camera: FlockCam
    var snapshotDate: Date? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Image("flock-cam")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                    AddressView(address: "\(camera.latitude), \(camera.longitude)")
                    
                    DescriptionView(description: "Manufacturer: \(camera.manufacturer ?? "Unknown")\nOperator: \(camera.operatorName ?? "Unknown")\nDirection: \(camera.direction ?? "Unknown")\nMount: \(camera.mount ?? "Unknown")")
                    
                    if let url = URL(
                        string: "https://www.openstreetmap.org/\(camera.id)"
                    ) {
                        Link(destination: url) {
                            Label("View OpenStreetMap record", systemImage: "arrow.up.right.square")
                        }
                    }
                    
                    if let snapshotDate {
                        Text("Data snapshot: \(snapshotDate.formatted(date: .abbreviated, time: .omitted))")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                    }

                    if let url = URL(string: "https://www.openstreetmap.org/copyright") {
                        Link("Camera data © OpenStreetMap contributors · ODbL",
                             destination: url)
                            .font(.footnote)
                    }
                        
                        
                }
            }
            .navigationTitle(camera.name ?? "Unknown Camera")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

#Preview {
    CameraDetailView(camera: FlockCam(id: "node/152704201", latitude: -95.5963941, longitude: 29.7829125, manufacturer: "ur mom", operatorName: "ur dad", direction: "northwest", mount: "uhhhh", name: "lol"))
}

struct Banner : View {
    var image: UIImage
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFill()
            .accessibilityHidden(true)
    }
}

struct AddressView : View {
    var address: String
    var body: some View {
        HStack {
            Label(address, systemImage: "mappin.and.ellipse")
                .foregroundStyle(.secondary)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct DescriptionView : View {
    var description: String
    var body: some View {
        Text(description)
            .frame(maxWidth: .infinity, alignment: .leading)
            .fixedSize(horizontal: false, vertical: true)
            .padding()
    }
}
