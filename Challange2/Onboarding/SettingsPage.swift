//
//  SettingsPage.swift
//  try
//
//  Created by alessia frezzetti on 10/10/24.
//

import SwiftUI

struct SettingsPage: View {
    @AppStorage("fullName") private var fullName: String = ""
    @AppStorage("dateOfBirth") private var dateOfBirthString: String = Date().description
    @AppStorage("sex") private var sex: String = "Male"
    @AppStorage("bio") private var bio: String = ""
    @AppStorage("h2hMessage") private var h2hMessage: String = "I don't feel safe, please reach me or call the cops."
    
    @FocusState private var isH2HMessageFocused: Bool
    
    private var dateOfBirth: Date {
        get {
            return ISO8601DateFormatter().date(from: dateOfBirthString) ?? Date()
        }
    }
    
    private func updateDateOfBirth(to newValue: Date) {
        dateOfBirthString = ISO8601DateFormatter().string(from: newValue)
    }
    
    var body: some View {
        VStack {
            Form {
                
            }
        }
    }
}

#Preview {
    SettingsPage()
}
