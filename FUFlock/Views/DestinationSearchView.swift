//
//  DestinationSearchView.swift
//  FUFlock
//
//  Created by Jordan Austin on 10/5/26.
//

import SwiftUI
import MapKit

struct DestinationSearchView: View {
    @ObservedObject var viewModel: DestinationSearchViewModel

    var body: some View {
        NavigationStack {
            List {
                if viewModel.isSearching {
                    ProgressView("Searching...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                } else {
                    ForEach(viewModel.results, id: \.self) { destination in
                        Button {
                            viewModel.selectedDestination = destination
                        } label: {
                            Label(
                                destination.name ?? "Unnamed destination",
                                systemImage: "mappin.circle"
                            )
                        }
                    }
                }
            }
            .navigationTitle("Destination")
            .searchable(
                text: $viewModel.query,
                prompt: "Search for a destination"
            )
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search()
                }
            }
        }
    }
}

#Preview {
    DestinationSearchView(viewModel: DestinationSearchViewModel())
}
