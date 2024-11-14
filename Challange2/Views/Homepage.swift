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
                                    Image("arrow")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                }
                            }
                            Spacer()
                            Button(action: {
                                currentLevel += 1
                            }) {
                                Image("arrow")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                                    .rotationEffect(.degrees(180))
                            }
                        }
                        .padding(.horizontal, 60)
                    }.padding(.vertical, 30)
                    VStack {  // Outer container
                        VStack {
                            HStack {
                                NavigationLink(
                                    destination: PlantInfoView(
                                        flowerName: "Daisy")
                                ) {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(.white)
                                                .shadow(radius: 5)
                                                .frame(width: 110, height: 120)
                                            Image("Daisy")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 115, height: 115)
                                        }
                                        Text("Daisy")
                                            .foregroundStyle(
                                                Color(
                                                    red: 60 / 255,
                                                    green: 99 / 255,
                                                    blue: 39 / 255)
                                            )
                                            .font(.system(size: 24))
                                    }
                                }
                                Spacer()
                                    .frame(width: 50)
                                NavigationLink(
                                    destination: PlantInfoView(
                                        flowerName: "Cactus")
                                ) {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(.white)
                                                .shadow(radius: 5)
                                                .frame(width: 110, height: 120)
                                            Image("Cactus")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 110, height: 110)
                                        }
                                        Text("Cactus")
                                            .foregroundStyle(
                                                Color(
                                                    red: 60 / 255,
                                                    green: 99 / 255,
                                                    blue: 39 / 255)
                                            )
                                            .font(.system(size: 24))
                                    }
                                }
                            }
                            Spacer().frame(height: 20)
                            HStack {
                                Image("SingleShelf")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 26)

                            }
                        }
                        Spacer().frame(height: 70)
                        VStack {
                            HStack {
                                NavigationLink(
                                    destination: PlantInfoView(
                                        flowerName: "Cyclamen")
                                ) {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(.white)
                                                .shadow(radius: 5)
                                                .frame(width: 110, height: 120)
                                            Image("Cyclamen")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 115, height: 115)
                                        }
                                        Text("Cyclamen")
                                            .foregroundStyle(
                                                Color(
                                                    red: 60 / 255,
                                                    green: 99 / 255,
                                                    blue: 39 / 255)
                                            )
                                            .font(.system(size: 24))
                                    }
                                }
                                Spacer()
                                    .frame(width: 50)
                                NavigationLink(
                                    destination: PlantInfoView(
                                        flowerName: "Rosemary")
                                ) {
                                    VStack {
                                        ZStack {
                                            Circle()
                                                .fill(.white)
                                                .shadow(radius: 5)
                                                .frame(width: 110, height: 120)
                                            Image("Rosemary")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 115, height: 115)
                                        }
                                        Text("Rosemary")
                                            .foregroundStyle(
                                                Color(
                                                    red: 60 / 255,
                                                    green: 99 / 255,
                                                    blue: 39 / 255)
                                            )
                                            .font(.system(size: 24))
                                    }
                                }
                            }
                            Spacer().frame(height: 20)
                            HStack {
                                Image("SingleShelf")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 26)
                            }
                        }
                    }
                    Spacer().frame(height: 60)
                    Button(action: {
                        self.showCameraView.toggle()
                    }
                    ) {
                        Image("ScanImage")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
                if showCameraView {
                    CameraView(
                        isShown: $showCameraView, image: $image,
                        showProgress: $showProgressView,
                        commonName: $commonName, plantName: $plantName,
                        probability: $probability
                    )
                    .statusBar(hidden: true)
                }
            }
            .ignoresSafeArea()
        }
        .edgesIgnoringSafeArea(.all)
        .padding(0)
    }
}

#Preview {
    Homepage(currentOnboardingView: .constant(6))
}
