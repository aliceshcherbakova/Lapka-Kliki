//
//  ContentView.swift
//  Lapka Kliki
//
//  Created by Аліса Щербакова on 25.07.25.
//

import SwiftUI
import SwiftData



@Model
class User {
    
    var name: String
    var balance: Int
    var progress: Int
    var booster: Int
    var lapka: Int
    var lapka1: Bool
    var lapka2: Bool
    var lapka3: Bool
    var lapka4: Bool
    var lapka5: Bool
    var lapka6: Bool
    
    init(name: String, balance: Int, progress: Int, booster: Int, lapka: Int, lapka1: Bool, lapka2: Bool, lapka3: Bool, lapka4: Bool, lapka5: Bool, lapka6: Bool) {
        self.name = name
        self.balance = balance
        self.progress = progress
        self.booster = booster
        self.lapka = lapka
        self.lapka1 = lapka1
        self.lapka2 = lapka2
        self.lapka3 = lapka3
        self.lapka4 = lapka4
        self.lapka5 = lapka5
        self.lapka6 = lapka6
    }
    
    func lapkaValue(for id: Int) -> Bool? {
            switch id {
            case 1: return lapka1
            case 2: return lapka2
            case 3: return lapka3
            case 4: return lapka4
            case 5: return lapka5
            case 6: return lapka6
            default: return nil
            }
    }
    
    func setLapka(for id: Int, to newValue: Bool) {
            switch id {
            case 1: lapka1 = newValue
            case 2: lapka2 = newValue
            case 3: lapka3 = newValue
            case 4: lapka4 = newValue
            case 5: lapka5 = newValue
            case 6: lapka6 = newValue
            default: break
            }
    }
}

struct ContentView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]

    func deleteAll<T: PersistentModel>(type: T.Type, context: ModelContext) {
        do {
            let all = try context.fetch(FetchDescriptor<T>())
            for item in all {
                context.delete(item)
            }
            try context.save()
        } catch {
            print("Ошибка при удалении всех \(T.self): \(error)")
        }
    }
    
    @State var toWelcome = false
    @State var toGame = false
    
    var body: some View {
        VStack {
           
        }
        .padding()
        .onAppear()
        {
            //deleteAll(type: User.self, context: modelContext)
            
            if (user.isEmpty)
            {
                toWelcome.toggle()
            }
            else
            {
                toGame.toggle()
            }
        }
        .fullScreenCover(isPresented: $toWelcome) {
            WelcomeView()
        }
        .fullScreenCover(isPresented: $toGame) {
            GameController()
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [User.self])
}
