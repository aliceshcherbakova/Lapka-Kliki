//
//  Lapka_KlikiApp.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI
import SwiftData

@main
struct Lapka_KlikiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [User.self])
        }
    }
}
