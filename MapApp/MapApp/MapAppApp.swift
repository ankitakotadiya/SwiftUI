//
//  MapAppApp.swift
//  MapApp
//
//  Created by Ankita Kotadiya on 29/01/25.
//

import SwiftUI

@main
struct MapAppApp: App {
    
    @StateObject private var vm = LocationViewModel()

    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
