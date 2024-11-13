import SwiftUI
import UIKit

struct Homepage: View {
    @Binding var currentOnboardingView: Int

    @State private var currentLevel: Int = 1
    @State private var showCameraView: Bool = false
    
    @State private var image: Image? = Image("appface")
    @State private var commonName: String = "Leefy"
    @State private var plantName: String = ""
    @State private var probability: String = ""

    @State private var showPhotoLibraryView: Bool = false
    @State private var showProgressView: Bool = false

    let impactFeedback = UIImpactFeedbackGenerator(style: .medium)

    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 200 / 255, green: 222 / 255, blue: 183 / 255)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    ZStack {
                        Text("Level \(currentLevel)")
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                            .font(.system(size: 38))
                        HStack {
                            if currentLevel != 1 {
                                Button(action: {
                                    currentLevel -= 1
                                }) {
                                    Rectangle().frame(width: 30, height: 25)
                                        .padding(.top, 5)
                                }
                            }
                            Spacer()
                            Button(action: {
                                currentLevel += 1
                            }) {
                                Rectangle().frame(width: 30, height: 25)
                                    .padding(.top, 5)
                            }
                        }
                        .padding(.horizontal, 60)
                    }.padding(.bottom, 40)
                    VStack {  // Outer container
                        VStack {
                            HStack {
                                Circle()
                                    .fill(.white)
                                    .shadow(radius: 5)
                                    .frame(width: 110, height: 120)
                                // Aquí podrías cargar las imágenes específicas del nivel
                                Spacer()
                                    .frame(width: 50)
                                Circle()
                                    .fill(.white)
                                    .shadow(radius: 5)
                                    .frame(width: 110, height: 120)
                            }
                            Spacer().frame(height: 20)
                            HStack {
                                Rectangle()
                                    .frame(width: 300, height: 15)
                            }
                        }
                        Spacer().frame(height: 70)
                        VStack {
                            HStack {
                                Circle()
                                    .fill(.white)
                                    .shadow(radius: 5)
                                    .frame(width: 110, height: 120)
                                Spacer()
                                    .frame(width: 50)
                                Circle()
                                    .fill(.white)
                                    .shadow(radius: 5)
                                    .frame(width: 110, height: 120)
                            }
                            Spacer().frame(height: 20)
                            HStack {
                                Rectangle()
                                    .frame(width: 300, height: 15)
                            }
                        }
                    }
                    Spacer().frame(height: 60)
                    Button(action: {
                        self.showCameraView.toggle()
                    }
                    ) {
                        Rectangle()
                            .frame(width: 100, height: 100)
                            .padding(.top, 20)
                    }
                }
            }
            if (showCameraView) {
                CameraView(isShown: $showCameraView, image: $image, showProgress: $showProgressView, commonName: $commonName, plantName: $plantName, probability: $probability)
                    .statusBar(hidden: true)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }
}

#Preview {
    Homepage(currentOnboardingView: .constant(6))
}
