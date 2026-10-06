//
//  AppTabView.swift
//  FUFlock
//
//  Created by Jordan Austin on 9/20/26.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            CameraMapView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            Text("Search Tab")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            Text("Profile Tab")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    AppTabView()
}
