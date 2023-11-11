//
//  SecureTextField.swift
//  Mealy
//
//  Created by Bryan Khufa on 11/11/23.
//

import SwiftUI

struct SecureTextField: View {
    
    var title: String
    @Binding var text: String
    @State var isSecure: Bool = true
    
    var body: some View {
        HStack{
            Group{
                if isSecure {
                    SecureField(title, text: $text)
                } else {
                    TextField(title, text: $text)
                }
            }
            .animation(.easeInOut(duration: 0.2), value: isSecure)
            Button(action: {
                isSecure.toggle()
            }, label: {
                Image(systemName: !isSecure ? "eye.slash" : "eye" )
            })
        }
    }
}

struct SecureTextField_Previews: PreviewProvider {
    static var previews: some View {
        SecureTextField(title: "password", text: .constant("1"))
    }
}
