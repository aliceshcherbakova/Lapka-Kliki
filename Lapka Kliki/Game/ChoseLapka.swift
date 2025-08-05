//
//  ChoseLapka.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 4.08.25.
//

import SwiftUI
import SwiftData
import AVFoundation

struct ChoseLapka: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    
    var body: some View {
        VStack
        {
            TabView {
                
                Lapka(id: 1)
                Lapka(id: 2)
                Lapka(id: 3)
                Lapka(id: 4)
                Lapka(id: 5)
                
            }
            .tabViewStyle(PageTabViewStyle())
        }

    }
}

struct Lapka: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State private var audioPlayer: AVAudioPlayer?

    var prices = [0, 13000, 21000, 35000, 50000, 230000]
    var id: Int
    
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
    
    private func buyLapka () {
        guard let firstUser = user.first else { return }
        
        if (firstUser.progress >= id)
        {
            if (firstUser.balance >= prices[id - 1])
            {
                firstUser.balance -= prices[id - 1]
                firstUser.setLapka(for: id, to: true)
                playSound(named: "pay")
            }
        }
        
        do {
            try modelContext.save()
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
    
    private func choseforGame()
    {
        guard let firstUser = user.first else { return }
        firstUser.lapka = id
        playSound(named: "click")
        do {
            try modelContext.save()
        } catch {
            print("Ошибка сохранения: \(error)")
        }
    }
    
    
   
    
    var body: some View {
       VStack
        {
            if (id == 1) {
                Text("Твоя первая лапка")
                    .font(.title)
            }
            else if (id == 2)
            {
                Text("Лапка")
                    .font(.title)
                Text("Традиционных ценностей")
                    .font(.title2)
                HStack
                {
                    Text("Р")
                        .font(.title)
                        .foregroundStyle(Color.red)
                    Text("О")
                        .font(.title)
                        .foregroundStyle(Color.orange)
                    Text("С")
                        .font(.title)
                        .foregroundStyle(Color.yellow)
                    Text("С")
                        .font(.title)
                        .foregroundStyle(Color.green)
                    Text("И")
                        .font(.title)
                        .foregroundStyle(Color.blue)
                    Text("И")
                        .font(.title)
                        .foregroundStyle(Color.indigo)
                    
                }
            }
            else if (id == 3)
            {
                Text("Лапка")
                    .font(.title2)
                Text("Чорни кот")
                    .font(.title)
            }
            else if (id == 4)
            {
                Text("Лапка")
                    .font(.title2)
                Text("Розовая")
                    .font(.title)
                    .foregroundStyle(Color.pink)
            }
            else if (id == 5)
            {
                Text("Лапка")
                    .font(.title2)
                Text("Традиционный секс")
                    .font(.title)
            }
            
            if (user[0].lapkaValue(for: id)!)
            {
                VStack
                {
                    HStack
                    {
                        Image(systemName: "cart.fill")
                        Text("Куплено")
                            .font(.title3)
                    }
                    
                    
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.green)
                )
            }
            else
            {
                VStack
                {
                    HStack
                    {
                        Image(systemName: "lock.fill")
                        Text("Не куплено")
                            .font(.title3)
                    }
                    
                    
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.red)
                )

            }
            
            Spacer()
            
            ZStack
            {
                if (id == 1)
                {
                    StartLapka().image
                        .resizable()
                        .frame(width: 240, height: 240)
                    
                }
                else if (id == 2)
                {
                    LGBTLapka().image
                        .resizable()
                        .frame(width: 240, height: 240)
                }
                else if (id == 3)
                {
                    BlackLapka().image
                        .resizable()
                        .frame(width: 240, height: 240)
                }
                else if (id == 4)
                {
                    PinkLapka().image
                        .resizable()
                        .frame(width: 240, height: 240)
                }
                else if (id == 5)
                {
                    SeksLapka().image
                        .resizable()
                        .frame(width: 240, height: 240)
                }
                
                
                if (!(user[0].progress >= id))
                {
                    Image(systemName: "lock.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.bar)
                }
            }
            
            VStack
            {
                
                Text(String(prices[id - 1]) + " кликов")
                    .font(.title3)
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.bar)
            )
            
            VStack
            {
                
                Text(String(id) + " потужности")
                    .font(.title3)
                
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.red)
            )
            
            Spacer()
            
            Button(action: {
                let haveLapka = user[0].lapkaValue(for: id)
                
                if (haveLapka!)
                {
                    if (user[0].lapka == id)
                    {
                        
                    }
                    else
                    {
                      choseforGame()
                    }
                }
                else
                {
                    if (user[0].progress >= id)
                    {
                        buyLapka()
                    }
                    else
                    {
                       
                    }
                    
                }
            }) {
                
                let haveLapka = user[0].lapkaValue(for: id)
                
                if (haveLapka!)
                {
                    if (user[0].lapka == id)
                    {
                        Text("Выбранная лапка")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Color.gray)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    else
                    {
                        Text("Выбрать для игры")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .semibold))
                    }
                }
                else
                {
                    if (user[0].progress >= id)
                    {
                        Text("Купить")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    else
                    {
                        Text("Не хватает потужности")
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 13)
                            .background(Color.red)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                            .font(.system(size: 17, weight: .semibold))
                    }
                    
                }
                
                
                
            }
            .padding(.horizontal, 5)
            
            
        }
        .padding()
        .padding(.bottom, 25)
    }
}

#Preview {
    ChoseLapka()
        .modelContainer(for: [User.self])
}
