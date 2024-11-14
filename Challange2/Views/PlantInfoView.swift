import SwiftUI

struct PlantInfoView: View {
    var flowerName: String
    var flowerInfo: FlowerInfo? {
        FlowerData[flowerName]
    }

    // A closure for dismissing the modal
    var onDismiss: (() -> Void)?
    @Environment(\.presentationMode) var presentationMode  // Para manejar la navegación hacia atrás

    var body: some View {
        ZStack {
            Color(red: 200 / 255, green: 222 / 255, blue: 183 / 255)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {

                ZStack {
                    // Go back button
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image("arrow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                        }
                        .padding(.leading)
                        Spacer()
                    }

                    ZStack {
                        Text(flowerInfo?.title ?? "")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)


                // Flower image and details
                HStack(alignment: .top, spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.696, green: 0.771, blue: 0.63))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Circle()
                                    .stroke(
                                        Color(
                                            red: 0.501, green: 0.607,
                                            blue: 0.443),
                                        lineWidth: 2)
                            )
                        Image(flowerInfo?.imageName ?? "")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 110, height: 110)
                    }

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Family")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.family ?? "")")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                        Spacer().frame(height: 5)
                        Text("Where to find it?")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.whereToFindIt ?? "")")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                        Spacer().frame(height: 5)
                        Text("Fun fact")
                            .font(.system(size: 14))
                        Text("\(flowerInfo?.funFact ?? "")")
                            .font(.system(size: 18))
                            .foregroundStyle(
                                Color(
                                    red: 60 / 255, green: 99 / 255,
                                    blue: 39 / 255)
                            )
                    }
                }
                .padding(.horizontal, 20)

                // Buttons in a grid layout
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Button(action: {
                            print("Button 1 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    Color(red: 0.917, green: 0.942, blue: 0.903)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(
                                        systemName:
                                            "photo.fill.on.rectangle.fill"
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 0.236, green: 0.388,
                                            blue: 0.154)
                                    )
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color(
                                                red: 0.72, green: 0.73,
                                                blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }

                        Button(action: {
                            print("Button 2 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    Color(red: 0.917, green: 0.942, blue: 0.903)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(
                                        systemName:
                                            "photo.fill.on.rectangle.fill"
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 0.236, green: 0.388,
                                            blue: 0.154)
                                    )
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color(
                                                red: 0.72, green: 0.73,
                                                blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                    }

                    HStack(spacing: 10) {
                        Button(action: {
                            print("Button 3 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    Color(red: 0.917, green: 0.942, blue: 0.903)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(
                                        systemName:
                                            "photo.fill.on.rectangle.fill"
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 0.236, green: 0.388,
                                            blue: 0.154)
                                    )
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color(
                                                red: 0.72, green: 0.73,
                                                blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }

                        Button(action: {
                            print("Button 4 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(
                                    Color(red: 0.917, green: 0.942, blue: 0.903)
                                )
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(
                                        systemName:
                                            "photo.fill.on.rectangle.fill"
                                    )
                                    .foregroundColor(
                                        Color(
                                            red: 0.236, green: 0.388,
                                            blue: 0.154)
                                    )
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(
                                            Color(
                                                red: 0.72, green: 0.73,
                                                blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
        }
        .navigationBarBackButtonHidden(true)  // Oculta el botón "Back" predeterminado
    }
}

#Preview {
    PlantInfoView(flowerName: "Cactus")
}
