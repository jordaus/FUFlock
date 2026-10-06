//
//  CameraMapViewModel.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/23/26.
//

import Foundation
internal import Combine

@MainActor final class CameraMapViewModel: ObservableObject {
    @Published var cameras: [FlockCam] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var snapshotDate: Date?
    
    private var hasLoaded = false
    
    
    
    func fetchCameraList() {
        guard !hasLoaded, !isLoading else { return }
        isLoading = true
        errorMessage = nil

        defer {
            isLoading = false
        }

        do {
            let snapshot = try CameraRepository.loadCameras()
            cameras = snapshot.cameras
            snapshotDate = snapshot.snapshotDate
            hasLoaded = true
        } catch {
            errorMessage = "Unable to load camera data."
            print("Camera loading failed:", error)
        }
    }
}
