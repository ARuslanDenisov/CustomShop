//
//  ImputView.swift
//  CustomShop
//
//  Created by Юрий on 15.09.2024.
//

import SwiftUI

struct InputView: View {
    @Binding var text: String
    let title: String
    let placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
            } else {
                TextField(placeholder, text: $text)
                    .padding()
                    .background(Color.secondary.opacity(0.2))
                    .cornerRadius(10)
            }
        }
    }
}

#Preview {
    InputView(text: .constant("Text"), title: "Title", placeholder: "Placeholder")
}
