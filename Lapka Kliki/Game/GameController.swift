//
//  GameController.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI

struct GameController: View {
    var body: some View {
        VStack
        {
            
            
            TabView {
                
                TapView()
                    .modelContainer(for: [User.self])
                    .tabItem {
                        Label("Тапать", systemImage: "house")
                    }
                
                ShopView()
                    .modelContainer(for: [User.self])
                    .tabItem {
                        Label("Магазин", systemImage: "cart.fill")
                    }
                ChoseLapka()
                    .modelContainer(for: [User.self])
                    .tabItem {
                        Label("Моя лапка", systemImage: "person.circle.fill")
                    }


                }
        }
    }
}

#Preview {
    GameController()
}
