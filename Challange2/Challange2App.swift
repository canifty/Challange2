//
//  Challange2App.swift
//  Challange2
//
//  Created by Can Dindar on 04/11/24.
//

import SwiftUI

@main
struct Challange2App: App {
    @State private var showSplash = true
    var body: some Scene {
        WindowGroup {
            if showSplash {
                SplashView(showSplash: $showSplash)
            } else {
                ContentView()
            }
        }
    }
}

struct SplashView: View {
    @Binding var showSplash: Bool
    @State var leafyStep = 0
    @State var nanoStep = 0
    
    var body: some View {
        ZStack {
            Color(red: 200 / 255, green: 222 / 255, blue: 183 / 255)
                .edgesIgnoringSafeArea(.all)
            
            Image("Leafy\(leafyStep)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .padding(100)
                .position(x: 200, y: 350)
                .shadow(color:.black,  radius: 0, y:3 )
            
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        leafyStep = (leafyStep + 1) % 4
                    }
                }
            
            Image("Nano\(nanoStep)")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 133)
                .padding(.top, 150)
                .position(x: 200, y: 550)
            
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        nanoStep = (nanoStep + 1) % 4
                    }
                }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    showSplash = false
                }
            }
        }
    }
}
