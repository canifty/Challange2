//
//  PlantInfoView.swift
//  Challange2
//
//  Created by Francesco Romeo on 11/11/24.
//

import SwiftUI

struct PlantInfoView: View {
    
    var body: some View {
        ZStack{
            Color("backcolor")
                .ignoresSafeArea()
            VStack(spacing: 30){
                HStack{
                    Image("arrow")
                        .padding(.leading)
                    Spacer()
                    Text("Daisy")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack(alignment: .top, spacing: 10){
                    Circle()
                        .fill(Color(red: 0.696, green: 0.771, blue: 0.63))
                        .frame(width: 150, height: 150)
                        .overlay(
                            Image("Daisy")
                                .frame(width: 190, height: 190)
                            )
                        .overlay(
                            Circle()
                                .stroke(Color(red: 0.501, green: 0.607, blue: 0.443), lineWidth: 2)
                                    )
                    VStack(alignment: .leading, spacing: 30){
                        Text(" - Fun Fact 1")
                            .font(.body)
                        
                        Text(" - Fun Fact 2")
                            .font(.body)
                        
                        Text(" - Fun Fact 3")
                            .font(.body)
                        
                    }
                    Spacer()
                    
                }
                .padding(.horizontal, 40.0)
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2))
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                            )
                    }
                    .padding(.top, 35.0)
                    
                    HStack(spacing: 10) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                            )
                        
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(red: 0.917, green: 0.942, blue: 0.903))
                            .frame(width: 150, height: 150)
                            .overlay(
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .foregroundColor(Color(red: 0.236, green: 0.388, blue: 0.154))
                                    .scaledToFill()
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(red: 0.72, green: 0.73, blue: 0.712), lineWidth: 2)
                            )
                    }
                }
                Spacer()
            }
            .padding(.top, 20)
        }
    }
}
#Preview {
    PlantInfoView()
}

