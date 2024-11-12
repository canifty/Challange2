//
//  ContentView.swift
//  Challange2
//
//  Created by Can Dindar on 04/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    
    var body: some View {
        CameraView(image: $viewModel.currentFrame)
    }
}


#Preview {
    ContentView()
}
