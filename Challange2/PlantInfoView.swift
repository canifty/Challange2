//
//  PlantInfoView.swift
//  Challange2
//
//  Created by Francesco Romeo on 11/11/24.
//
import SwiftUI


struct PlantInfoView: View {
    var flowerName: String
    var flowerInfo: FlowerInfo? {
        FlowerData[flowerName]
    }
    
    // A closure for dismissing the modal
    var onDismiss: (() -> Void)?
    
    var body: some View {
        ZStack {
            Color("backcolor")
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // Top navigation and title
                HStack {
                    Button(action: {
                        onDismiss?() // Call the dismiss action
                    }) {
                        Image("arrow")
                            .padding(.leading)
                    }
                    Spacer()
                    Text(flowerInfo?.title ?? "")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                
                // Flower image and details
                HStack(alignment: .top, spacing: 10) {
                    Circle()
                        .fill(Color(red: 0.696, green: 0.771, blue: 0.63))
                        .frame(width: 150, height: 150)
                        .overlay(
                            Image(flowerInfo?.imageName ?? "")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                        )
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.501, green: 0.607, blue: 0.443), lineWidth: 2)
                        )
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Family: \(flowerInfo?.family ?? [""])")
                            .font(.body)
                        Text("Where to Find It: \(flowerInfo?.whereToFindIt ?? "")")
                            .font(.body)
                        Text("Fun Fact: \(flowerInfo?.funFact ?? "")")
                            .font(.body)
                    }
                    Spacer()
                    
                }
                .padding(.horizontal, 40.0)
                
                // Buttons in a grid layout
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        Button(action: {
                            print("Button 1 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(systemName: "photo.fill.on.rectangle.fill")
                                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                        
                        Button(action: {
                            print("Button 2 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(systemName: "photo.fill.on.rectangle.fill")
                                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                    }
                    
                    HStack(spacing: 10) {
                        Button(action: {
                            print("Button 3 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(systemName: "photo.fill.on.rectangle.fill")
                                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                        
                        Button(action: {
                            print("Button 4 pressed")
                        }) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                                .frame(width: 150, height: 150)
                                .overlay(
                                    Image(systemName: "photo.fill.on.rectangle.fill")
                                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                        .scaledToFill()
                                        .frame(width: 90, height: 90)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                                )
                                .padding(.top)
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}

#Preview {
    PlantInfoView(flowerName: "Cactus")
}
