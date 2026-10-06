//
//  CameraMapView.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/21/26.
//

import SwiftUI
import MapKit

struct CameraMapView: View {
    
    @StateObject var viewModel = CameraMapViewModel()
    
    @State private var selectedCamera: FlockCam?
    
    var body: some View {
        ZStack {
            Map(
                initialPosition: .region(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(
                        latitude: 29.7604,
                        longitude: -95.36057
                    ),
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                )),
                selection: $selectedCamera
            )
            {
                ForEach(viewModel.cameras) { camera in
                    Marker(
                        camera.name ?? "ALPR camera",
                        systemImage: "camera.fill",
                        coordinate: CLLocationCoordinate2D(
                            latitude: camera.latitude,
                            longitude: camera.longitude
                        )
                    )
                    .tag(camera)
                }
            }
            .ignoresSafeArea()
        }
        .sheet(item: $selectedCamera) { camera in
            CameraDetailView(
                camera: camera,
                snapshotDate: viewModel.snapshotDate
            )
            .presentationDragIndicator(.visible)
        }
        .onAppear {
            viewModel.fetchCameraList()
        }
        .safeAreaInset(edge: .bottom) {
            Text(viewModel.errorMessage ?? "\(viewModel.cameras.count) cameras loaded")
                .font(.footnote)
                .padding(8)
                .frame(maxWidth: .infinity)
                .background(.regularMaterial)
        }
    }
}

#Preview {
    CameraMapView()
}
