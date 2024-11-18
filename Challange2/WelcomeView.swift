//
//  WelcomeView.swift
//  Challange2
//
//  Created by cinzia ferrara on 11/11/24.
//

import SwiftUI

struct WelcomeView: View {
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
                .position(x: 200, y: 550) // Posiziona l'immagine
            
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                        nanoStep = (nanoStep + 1) % 4
                    }
                }
        }
    }
}
  

#Preview {
    WelcomeView()
}
