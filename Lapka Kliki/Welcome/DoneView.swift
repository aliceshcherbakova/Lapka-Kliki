//
//  DoneView.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI

struct DoneView: View {
    
    @State var toStart = false
    
    var body: some View {
        VStack
        {
            Spacer()
            
            Image(systemName: "face.smiling.inverse")
                .font(.system(size: 80))
                .foregroundStyle(Color.green)
            
            Text("Все готово!")
                .font(.title)
            Spacer()
            
            Button(action: {
                toStart.toggle()
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
        .fullScreenCover(isPresented: $toStart) {
            ContentView()
        }
    }
}

#Preview {
    DoneView()
}
