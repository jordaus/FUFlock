//
//  DestinationSearchViewModel.swift
//  FUFlock
//
//  Created by Jordan Austin on 10/5/26.
//

import Foundation
import MapKit
internal import Combine

@MainActor final class DestinationSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [MKMapItem] = []
    @Published var selectedDestination: MKMapItem?
    @Published var isSearching = false
    @Published var errorMessage: String?
    
    func searchPlaces(query: String) async throws -> [MKMapItem] {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = query
        request.resultTypes = [.address, .pointOfInterest]
        request.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: 29.7604,
                longitude: -95.3698
            ),
            span: MKCoordinateSpan(
                latitudeDelta: 0.6,
                longitudeDelta: 0.7
            )
        )

        let response = try await MKLocalSearch(request: request).start()
        return response.mapItems
    }
    
    func search() async {
        guard !isSearching else { return }

        let searchText = query.trimmingCharacters(in: .whitespacesAndNewlines)
        errorMessage = nil
        results = []

        guard !searchText.isEmpty else { return }

        isSearching = true
        defer { isSearching = false }

        do {
            results = try await searchPlaces(query: searchText)
        } catch is CancellationError {
            // Cancellation isn't a search failure.
        } catch {
            errorMessage = "Unable to search for destinations."
            print("Destination search failed:", error)
        }
    }
}
