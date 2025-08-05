//
//  MeetView.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI
import SwiftData

struct MeetView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    @State var name = ""
    @State var toDone = false
    
    var body: some View {
        VStack
        {
            Spacer()
            Text("Как тебя зовут?")
                .font(.title)
            
            TextField("Имя", text: $name)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 16)
                                    .background(Color(.systemGray6))
                                    .cornerRadius(12)
                                    .padding(.horizontal, 5)
            
            
            Spacer()
            Button(action: {
                if (name != "")
                {
                    modelContext.insert(User(name: name, balance: 10, progress: 1, booster: 2, lapka: 1, lapka1: true, lapka2: false, lapka3: false, lapka4: false, lapka5: false, lapka6: false))
                    
                    // modelContext.insert(Lapki(lapka: [true, false, false, false, false, false]))
                    
                    do {
                        try modelContext.save()
                        print("✅ User saved")
                    } catch {
                        print("❌ Save failed:", error.localizedDescription)
                    }
                    
                    toDone.toggle()
                }
                
            }) {
                Text("Продолжить")
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 13)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
                    .font(.system(size: 17, weight: .semibold))
            }
            .padding(.horizontal, 5)
        }
        .padding()
        .fullScreenCover(isPresented: $toDone) {
            DoneView()
        }
        
    }
}

#Preview {
    MeetView()
}
