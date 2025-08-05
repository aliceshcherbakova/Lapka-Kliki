//
//  WelcomeView.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI

struct WelcomeView: View {
    
    @State var toMeet = false
    
    var body: some View {
        VStack
        {
            Spacer()
            
                Text("Привет!")
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom)
            
                Image("lapka")
                .resizable()
                .frame(width: 200, height: 200)
                .padding(.bottom)
            
                Text("Добро пожаловать в Табалапку")
                .font(.title2)
            Spacer()
            Button(action: {
                toMeet.toggle()
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
        .fullScreenCover(isPresented: $toMeet) {
            MeetView()
                .modelContainer(for: [User.self])
        }
    }
}

#Preview {
    WelcomeView()
}
