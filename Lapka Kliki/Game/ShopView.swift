//
//  ShopView.swift
//  Lapka Kliki
//
//  Created by Алиса Щербакова on 31.07.25.
//

import SwiftUI
import SwiftData



struct ShopView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var user: [User]
    @State var alert = false
    @State var reason = ""
    @State var newLevel = false
    
    
    struct LapkaAnswer {
        var result: Bool
        var reason: String?
    }
    
    func buynewLapka() -> LapkaAnswer
    {
        var lapka = LapkaAnswer(result: false)
        
        guard let firstUser = user.first else { return lapka }
        
        if (firstUser.progress < 6)
        {
            if let u = user.first {
                let price = (u.booster * u.progress) * 20
                if (firstUser.balance >= price)
                {
                    
                    firstUser.balance -= price
                    firstUser.progress += 1
                    
                    lapka.result = true
                    do {
                        try modelContext.save()
                    } catch {
                        print("Ошибка сохранения: \(error)")
                    }
                }
                else
                {
                    lapka.result = false
                    lapka.reason = "Недостаточно средств"
                }
            }
            
            
        }
        else
        {
            lapka.reason = "У вас максимальный уровень лапки"
        }
        
        return lapka
    }
    
    func buyBooster() -> LapkaAnswer
    {
        var lapka = LapkaAnswer(result: false)
        
        guard let firstUser = user.first else { return lapka }
        
        if let u = user.first {
            if (firstUser.balance >= (Int(pow(Double(u.booster), 1.5) * 100)))
            {
                
                firstUser.balance -= (Int(pow(Double(u.booster), 1.5) * 100))
                firstUser.booster += firstUser.booster
                
                lapka.result = true
                do {
                    try modelContext.save()
                } catch {
                    print("Ошибка сохранения: \(error)")
                }
            }
            else
            {
                lapka.result = false
                lapka.reason = "Недостаточно средств"
            }
        }
            
      
        
        return lapka
    }
    
    var body: some View {
        ScrollView
        {
            VStack {
                HStack
                {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 25))
                        .foregroundStyle(Color.blue)
                    Text("Баланс: " + String(user.first?.balance ?? 0))
                    Spacer()
                }.padding()
                
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                    }
                    Text("Потужність лапки")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    HStack(spacing: 8) {
                        ForEach(0..<6) { y in
                            if (user.first?.progress ?? 0 > y)
                            {
                                VStack
                                {
                                    Text(String(y + 1))
                                    Capsule()
                                        .fill(Color.blue.opacity(0.5))
                                        .frame(width: 30, height: 6)
                                }
                                
                            }
                            else
                            {
                                VStack
                                {
                                    
                                    Text(String(y + 1))
                                    Capsule()
                                        .fill(Color.black.opacity(0.5))
                                        .frame(width: 30, height: 6)
                                }
                            }
                        }
                    }.padding(.bottom)
                    
                    Button(action: {
                        let buy = buynewLapka()
                        if (buy.result == false)
                        {
                            reason = buy.reason ?? ""
                            alert.toggle()
                        }
                        else
                        {
                            newLevel.toggle()
                        }
                        
                    }) {
                        
                        if let u = user.first {
                            Text("До-дєп | Цена: \((u.booster * u.progress) * 20)")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .semibold))
                        }
                        
                    }
                    .padding(.horizontal, 5)
                    
                    
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.bar)
                )
                .padding(.horizontal)
                
            }
            .padding(.bottom, 10)
            .alert("Какая неудача", isPresented: $alert) {
                Button("ОК", role: .cancel) { }
            } message: {
                Text(reason)
            }
            .alert("Поздравляем!", isPresented: $newLevel) {
                        Button("ОК", role: .cancel) { }
                    } message: {
                        Text("Ты достиг(ла) \(user.first?.progress ?? 0) уровня")
                    }
            
            VStack {
                
                
                VStack {
                    HStack {
                        Spacer()
                        Spacer()
                    }
                    Text("Бустер")
                        .font(.title2)
                        .padding(.bottom, 10)
                    
                    Text("+ " + String(user.first?.booster ?? 0))
                        .font(.title)
                    
                    Button(action: {
                        let buy = buyBooster()
                        if (buy.result == false)
                        {
                            reason = buy.reason ?? ""
                            alert.toggle()
                        }
                       
                        
                    }) {
                        if let u = user.first {
                            Text("До-дєп | Цена: \(Int(pow(Double(u.booster), 1.5) * 100)) 🧪")
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 13)
                                .background(Color.blue)
                                .foregroundStyle(.white)
                                .cornerRadius(12)
                                .font(.system(size: 17, weight: .semibold))
                        }
                        
                    }
                    .padding(.horizontal, 5)
                    
                    
                    
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .fill(.bar)
                )
                .padding(.horizontal)
                
            }
        
        }
        
    }
}

#Preview {
    ShopView()
        .modelContainer(for: [User.self])
}
