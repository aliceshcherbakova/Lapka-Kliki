//
//  TapView.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 25.07.25.
//

import SwiftUI
import SwiftData
import AVFoundation

struct TapView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State private var isPulsing = false
    @State private var audioPlayer: AVAudioPlayer?
    
    private func playSound(named soundName: String) {
        if let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.play()
            } catch {
                print("Ошибка при попытке воспроизвести звук: \(error.localizedDescription)")
            }
        } else {
            print("Файл \(soundName).mp3 не найден")
        }
    }
    
    private func increaseBalance() {
            guard let firstUser = user.first else { return }
            
            // Увеличиваем баланс на 10
        firstUser.balance += firstUser.booster
        playSound(named: "moneta")
            
            // Сохраняем изменения в модели
            do {
                try modelContext.save()
            } catch {
                print("Ошибка сохранения: \(error)")
            }
        }
    
    
        
    
    var body: some View {
        ZStack {
            if (user[0].lapka == 1)
            {
                Image("background1")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container, edges: .top)
            }
            else if (user[0].lapka == 2) {
                Image("background2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container, edges: .top)
            }
            else if (user[0].lapka == 3)
            {
                Image("background3")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container, edges: .top)
            }
            else if (user[0].lapka == 4)
            {
                Image("background4")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container, edges: .top)
            }
            else if (user[0].lapka == 5)
            {
                Image("background5")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.container, edges: .top)
            }

                VStack {
                    
                    VStack
                    {
                        HStack
                        {
                            Spacer()
                        }
                        
                        Text("Счёт")
                            .font(.title2)
                        
                        Text(String(user.first?.balance ?? 1))
                            .font(.title)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.bar)
                    )
                    .padding()
                    
                    if (user[0].lapka == 1)
                    {
                        StartLapka().image
                            .resizable()
                            .frame(width: 240, height: 240)
                            .scaleEffect(isPulsing ? 1.2 : 1.0) // ← Пульс
                            .animation(.easeInOut(duration: 0.1), value: isPulsing)
                            .onTapGesture {
                                isPulsing = true
                                increaseBalance()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isPulsing = false
                                }
                            }
                    }
                    else if (user[0].lapka == 2)
                    {
                        LGBTLapka().image
                            .resizable()
                            .frame(width: 240, height: 240)
                            .scaleEffect(isPulsing ? 1.2 : 1.0) // ← Пульс
                            .animation(.easeInOut(duration: 0.1), value: isPulsing)
                            .onTapGesture {
                                isPulsing = true
                                increaseBalance()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isPulsing = false
                                }
                            }
                    } else if (user[0].lapka == 3)
                    {
                        BlackLapka().image
                            .resizable()
                            .frame(width: 240, height: 240)
                            .scaleEffect(isPulsing ? 1.2 : 1.0) // ← Пульс
                            .animation(.easeInOut(duration: 0.1), value: isPulsing)
                            .onTapGesture {
                                isPulsing = true
                                increaseBalance()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isPulsing = false
                                }
                            }
                    }
                    else if (user[0].lapka == 4)
                   {
                       PinkLapka().image
                           .resizable()
                           .frame(width: 240, height: 240)
                           .scaleEffect(isPulsing ? 1.2 : 1.0) // ← Пульс
                           .animation(.easeInOut(duration: 0.1), value: isPulsing)
                           .onTapGesture {
                               isPulsing = true
                               increaseBalance()
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                   isPulsing = false
                               }
                           }
                   }
                    
                    else if (user[0].lapka == 5)
                   {
                       SeksLapka().image
                           .resizable()
                           .frame(width: 240, height: 240)
                           .scaleEffect(isPulsing ? 1.2 : 1.0) // ← Пульс
                           .animation(.easeInOut(duration: 0.1), value: isPulsing)
                           .onTapGesture {
                               isPulsing = true
                               increaseBalance()
                               DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                   isPulsing = false
                               }
                           }
                   }
                    
                    
                    
                    
                }
                .padding()
            }
    }


}

#Preview {
    TapView()
        .modelContainer(for: [User.self])
}
