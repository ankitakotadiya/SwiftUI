//
//  InputField.swift
//  Login-Signup-SwiftUI
//
//  Created by Ankita Kotadiya on 21/11/24.
//

import SwiftUI

struct InputField: View {
    @Binding var field: String
    var isSecure: Bool = false
    var placeHolder: String
    
    var body: some View {
        Group {
            if isSecure {
                SecureField(placeHolder, text: $field)
            } else {
                TextField(placeHolder, text: $field)
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.gray, lineWidth: 1)
        )
        .font(.headline)
        .fontWeight(.regular)
        .foregroundStyle(Color.primary)
    }
}

//#Preview {
//    InputField()
//}
